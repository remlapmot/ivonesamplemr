*! version 0.1.0 12sep2021 Tom Palmer
* Acknowledge prefix command code from 
* https://www.elwyndavies.com/stata-tips/create-a-stata-program-that-functions-as-a-prefix/
program define ivmw

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
syntax, Window(numlist >0 max=1 integer) par(string) [*]
local leftoptions `options'

* Run any code you want to run before the command on the right
local 0 : copy local right
syntax [anything] [if] [in] [, *]
tokenize `"`right'"'
local ivcmdname `1'
macro shift
local rest `*'
_iv_parse `rest'
local lhs `s(lhs)'
local endog `s(endog)'
local exog `s(exog)'
local inst `s(inst)'

qui regress `endog' `inst' `exog' `if'`in'
tempvar residuals
qui predict double `residuals' `if'`in', residuals
tempfile origdata
qui save `origdata'
sort `residuals'
tempvar order
qui gen int `order' = _n
tsset `order'
tempfile newdata
qui save `newdata'

* Now, run the command on the right
rolling _b _se, window(`window') `leftoptions' saving(ivmwresults, replace): `right'

// collect median of endog in each window
tempfile ivmwmedres
qui rolling median = r(p50), window(`window') saving(`ivmwmedres', replace): ///
    summarize `endog' `if'`in', detail

* Run any code you want to run after the command on the right
use ivmwresults, clear
qui merge 1:1 start using `ivmwmedres'
qui save, replace
label variable median "Median of exposure in moving window"
if "`ivcmdname'" == "ivreg2" {
    local bpar _b_`par'
    local spar _se_`par'
}
if "`ivcmdname'" == "ivmsmm" {
    local bpar `lhs'_b_`par'
    local spar `lhs'_se_`par'
}
if "`ivcmdname'" == "ivlsmm" {
    local bpar cmxb_`par'_b_cons
    local spar cmxb_`par'_se_cons
}
if inlist("`ivcmdname'", "ivtsri", "ivtsps") {
    local bpar `par'_b_cons
    local spar `par'_se_cons
}
qui gen lowci = `bpar' - 1.96 * `spar'
qui gen uppci = `bpar' + 1.96 * `spar'
twoway line `bpar' uppci lowci median, sort(median) ///
    lc(gs0 gs10 gs10) lw(medthick medthick medthick) ///
    legend(rows(1) order(1 "Estimated causal effect" 2 "95% CI limits"))

tsset, clear
use `origdata', clear

end
