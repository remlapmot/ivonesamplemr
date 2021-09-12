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
syntax, suffix(str asis) [noOUTPUT width(real 0.45) noNOTE *]
  
* Run any code you want to run before the command on the right
_iv_parse `0'
local lhs `s(lhs)'
local endog `s(endog)'
local exog `s(exog)'
local inst `s(inst)'

qui regress `endog' `inst' `exog' `if'`in'
tempvar residuals
qui predict double `residuals', residuals
preserve
sort `residuals'
tempvar order
qui gen int `order' = _n
tsset `order'

* Now, run the command on the right
rolling, window(50) : `right'
tsset, clear

* Run any code you want to run after the command on the right
restore

end
