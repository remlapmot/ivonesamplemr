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
syntax, Window(numlist >0 max=1 integer) [*]
local leftoptions `options'

* Run any code you want to run before the command on the right
local 0 : copy local right
syntax [anything] [if] [in] [, *]
tokenize `right'
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
rolling, window(`window') `leftoptions' saving(mwresults, replace): `right'

* Run any code you want to run after the command on the right
tsset, clear
use `origdata', clear

end
