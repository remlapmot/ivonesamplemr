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
syntax, par(string) [SAving(string) *]
local leftoptions `options'
if "`saving'" == "" {
	tempfile saving
	local savefilename `saving'
}
else {
	tokenize `"`saving'"', parse(",")
	local savefilename `1'
	di "`savefilename'"
}

// tempfile origdata
// qui save `origdata'

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

tempvar resquartiles
xtile `resquartiles' = `residuals' `if'`in', `leftoptions'
levelsof `resquartiles' `if'`in'
local levels = r(levels)
di "`levels'"

* Now, run the command on the right
foreach quart of local levels {
	di "`quart'"
}


// use `origdata', clear

end
