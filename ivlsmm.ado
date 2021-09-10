*! 1.0.0 Tom Palmer 01sep2021
program ivlsmm, eclass

if _caller() >= 11 {
    local vv : di "version " string(_caller()) ":"
}
version 10

local replay = replay()

if replay() {
    if `"`e(cmd)'"' != "ivlsmm" { 
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

Display , level(`level') lhs(`lhs') endog(`endog') exog(`exog') inst(`inst')

ereturn local cmd "ivlsmm"
ereturn local cmdline `"ivlsmm `0'"'
ereturn local lhs `lhs'
ereturn local endog `endog'
ereturn local exog `exog'
ereturn local inst `inst'
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
	qui logit `lhs' `amxb' `if'`in'
	mat `from' = e(b)
	
	// tsri fit for causal model starting initial values
	tempvar s1res
	qui regress `endog' `inst' `exog' `if'`in'
	qui predict `s1res' `if'`in'
	qui logit `lhs' `endog' `exog' `s1res' `if'`in'
	tempname s2b
	mat `s2b' = e(b)
	local lengths2b = colsof(`s2b')
	mat `s2b' = (`s2b'[1, 1..`=`lengths2b' - 2'], `s2b'[1, `lengths2b']) // drop the `s1res' column
	mat `from' = (`from', `s2b')
}

// lsmm fit
local p1 "invlogit({xb:} + {b0})"
local d1 "-1*`p1'*(1 - `p1')"
local p2 "invlogit({xb:} + {b0} - {cmxb:})"
local d2 "`p2'*(1 - `p2')"

gmm (`lhs' - invlogit({xb:`amxb'} + {b0})) ///
	(invlogit({xb:} + {b0} - {cmxb:`endog' `exog'}) - {ey0}) ///
	`if'`in', ///
	instruments(1:`amxb') ///
	instruments(2:`inst' `exog') ///
	winitial(unadjusted, independent) from(`from') ///
	deriv(1/xb = `d1') ///
	deriv(1/b0 = `d1') ///
	deriv(2/xb = `d2') ///
	deriv(2/b0 = `d2') ///
	deriv(2/cmxb = -1*`d2') ///
	deriv(2/ey0 = -1) ///
	`options'

end


program Display, rclass
version 10
syntax [anything] [, Level(cilevel) lhs(varname) endog(varlist) exog(varlist) inst(varlist) replay(integer 0)]

if `replay' == 1 {
	display
	_coef_table , level(`level')
}
else {
	qui _coef_table , level(`level') // to return r(table)
}

return add

foreach var of varlist `endog' `exog' {
	di _n as txt "Causal odds ratio for: `var'"
	lincom /cmxb_`var', eform
}

end
