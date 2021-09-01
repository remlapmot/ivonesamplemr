// lsmm cscript
// 2021-08-27

cscript lsmm // adofiles lsmm



cap noi prog drop lsmm

program lsmm, eclass

if _caller() >= 11 {
    local vv : di "version " string(_caller()) ":"
}
version 10


if replay() {
    if `"`e(cmd)'"' != "lsmm" { 
        error 301
    }
    else if _by() { 
        error 190 
    }
    else {
        Display `0'
    }
    exit
}

Estimate `0'
ereturn local cmdline `"lsmm `0'"'
end

program Estimate, eclass

version 10

_iv_parse `0'
local lhs `s(lhs)'
local endog `s(endog)'
local exog `s(exog)'
local inst `s(inst)'
local 0 `s(zero)'

syntax [if] [in] [, Level(cilevel) AMxb(varlist numeric) FROM(string) *]

marksample touse
markout `touse' `lhs' `exog' `inst' `endog'

if "`amxb'" == "" {
	local amxb "`endog' `inst' `exog'"
}

if "`from'" == "" {
	// logistic regression for association model starting values
	tempname from
	qui logit `lhs' `amxb'
	mat `from' = e(b)
	
	// tsri fit for causal model starting initial values
	tempvar s1res
	qui regress `endog' `inst' `exog' `if'`in'
	qui predict `s1res' `if'`in'
	qui logit `lhs' `endog' `exog' `s1res'
	tempname s2b
	mat `s2b' = e(b)
	local lengths2b = colsof(`s2b')
	mat `s2b' = (`s2b'[1, 1..`=`lengths2b' - 2'], `s2b'[1, `lengths2b']) // drop the `s1res' column
	mat `from' = (`from', `s2b')
}

local p1 "invlogit({xb:} + {b0})"
local d1 "-1*`p1'*(1 - `p1')"
local p2 "invlogit({xb:} + {b0} - x*{psi})"
local d2 "`p2'*(1 - `p2')"
gmm (y - invlogit({xb:`am'} + {b0})) ///
	(invlogit({xb:} + {b0} - x*{psi}) - {ey0}), ///
	instruments(1:`endog' `am') ///
	instruments(2:`inst') ///
	winitial(unadjusted, independent) from(from) ///
	deriv(1/xb = `d1') ///
	deriv(1/b0 = `d1') ///
	deriv(2/xb = `d2') ///
	deriv(2/b0 = `d2') ///
	deriv(2/psi = -1*x*`d2') ///
	deriv(2/ey0 = -1)

end

clear
set obs 2500
set seed 12345
gen z1 = rbinomial(2, .2)
gen z2 = rbinomial(2, .3)
gen z3 = rbinomial(2, .4)
gen u = rnormal()
gen w = rnormal()
gen x = z1 + z2 + z3 + w + u + rnormal()
gen logitpy = -2 + x + w + u
gen py = invlogit(logitpy)
gen y = rbinomial(1, py)

lsmm y w (x = z1 z2 z3)

gen x1 = x
gen x2 = rnormal()
lsmm y w (x1 x2 = z1 z2 z3)
