*! 1.0.0 Tom Palmer 05sep2021
program tsps, eclass

if _caller() >= 11 {
    local vv : di "version " string(_caller()) ":"
}
version 10

local replay = replay()

if replay() {
    if `"`e(cmd)'"' != "lsmm" { 
        error 301
    }
    else if _by() { 
        error 190 
    }
    else {
        Display , lhs(`e(lhs)') endog(`e(endog)') exog(`e(exog)') inst(`e(inst)') replay(`replay')
    }
    exit
}

Estimate `0'

_iv_parse `0'
local lhs `s(lhs)'
local endog `s(endog)'
local exog `s(exog)'
local inst `s(inst)'
local 0 `s(zero)'

Display , level(`level') lhs(`lhs') endog(`endog') exog(`exog') inst(`inst')

ereturn local cmd "tsps"
ereturn local cmdline `"tsps `0'"'
ereturn local lhs `lhs'
ereturn local endog `endog'
ereturn local exog `exog'
ereturn local inst `inst'
end
