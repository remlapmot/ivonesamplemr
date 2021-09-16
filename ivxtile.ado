*! version 0.1.0 16sep2021 Tom Palmer
* Acknowledge prefix command code from 
* https://www.elwyndavies.com/stata-tips/create-a-stata-program-that-functions-as-a-prefix/
program define ivxtile

version 10

* Split the overall command, stored in `0' in a left and right part.
gettoken left right2 : 0, parse(":")
if `"`left'"' == ":" {
    local right `"`right2'"'
}
else {
    gettoken right3 right : right2, parse(":")
}

* Now, do the regular syntax parsing
local 0 : copy local left
local 0 = subinstr("`0'", ":", "", .)
syntax, par(string) [SAving(string) trace *]
local leftoptions `options'
if "`saving'" == "" {
	tempfile saving
	local savefilename `saving'
	local savereplace ""
}
else {
	tokenize `"`saving'"', parse(",")
	local savefilename `1'
	local savereplace `2' `3'
}

tempfile origdata
qui save `origdata'

* Run any code you want to run before the command on the right
local 0 : copy local right
syntax [anything] [if] [in] [, *]
tokenize `"`right'"'
local ivcmdname `1'
macro shift
local rest `*'
if "`ivcmdname'" == "ivregress" {
	local rest = subinstr("`rest'", "2sls", "", .)
	local rest = subinstr("`rest'", "liml", "", .)
	local rest = subinstr("`rest'", "gmm", "", .)
}
_iv_parse `rest'
local lhs `s(lhs)'
local endog `s(endog)'
local exog `s(exog)'
local inst `s(inst)'

qui regress `endog' `inst' `exog' `if'`in'
tempvar residuals
qui predict double `residuals' `if'`in', residuals

tempvar resquantiles
xtile `resquantiles' = `residuals' `if'`in', `leftoptions'
qui levelsof `resquantiles' `if'`in'
local levels = r(levels)

* Now, run the command on the right
if inlist("`ivcmdname'", "ivtsps", "ivtsri") local par `par':_cons
if "`ivcmdname'" == "ivlsmm" local par cmxb_`par':_cons
tempname memhold
postfile `memhold' quantile beta se using `savefilename' `savereplace'
if "`trace'" == "" local quietly quietly
`quietly' foreach quant of local levels {
	di _n "First stage residuals quantile: `quant'" _n
	preserve
	qui count if `resquantiles' == `quant'
	if `r(N)' == 0 {
		di as error "No observations in quantile `quant'"
		error 2000
	}
	else if `r(N)' > 0 & `r(N)' < 10 {
		di as txt "Only `r(N)' observations in quantile `quant'"
	}
	qui keep if `resquantiles' == `quant'
	`right'
	post `memhold' (`quant') (_b[`par']) (_se[`par'])
	restore
}
postclose `memhold'
use `savefilename', clear
qui gen lowci = beta - 1.96 * se
qui gen uppci = beta + 1.96 * se
list , clean noobs

twoway line b lowci uppci quantile, sort(quantile) ///
	lc(gs0 gs10 gs10) lw(medthick medthick medthick) ///
	legend(rows(1) order(1 "Estimated causal effect" 2 "95% CI limits")) ///
	ytitle("Estimated causal effect")

use `origdata', clear

end
