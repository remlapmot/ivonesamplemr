*! 1.0.0 Tom Palmer 05sep2021
program tsri, eclass

if _caller() >= 11 {
    local vv : di "version " string(_caller()) ":"
}
version 10

local replay = replay()

if replay() {
    if `"`e(cmd)'"' != "tsri" { 
        error 301
    }
    else if _by() { 
        error 190 
    }
    else {
        Display , lhs(`e(lhs)') endog(`e(endog)') exog(`e(exog)') inst(`e(inst)') replay(`replay') ///
			link(`e(link)') `e(estonly)'
    }
    exit
}

Estimate `0'
local link `e(link)'
local estonly `e(estonly)'

_iv_parse `0'
local lhs `s(lhs)'
local endog `s(endog)'
local exog `s(exog)'
local inst `s(inst)'

Display , level(`level') lhs(`lhs') endog(`endog') exog(`exog') inst(`inst') link(`link') `estonly'

ereturn local cmd "tsri"
ereturn local cmdline `"tsri `0'"'
ereturn local lhs `lhs'
ereturn local endog `endog'
ereturn local exog `exog'
ereturn local inst `inst'
ereturn local link `link'
end


program Estimate, eclass

version 10

_iv_parse `0'
local lhs `s(lhs)'
local endog `s(endog)'
local exog `s(exog)'
local inst `s(inst)'
local 0 `s(zero)'

syntax [if] [in] [, Level(cilevel) s1xb(varlist numeric) Link(string) FROM(string) estonly *]

marksample touse
markout `touse' `lhs' `exog' `inst' `endog'

if "`link'" == "" local link identity

if !inlist("`link'", "identity", "logadd", "logmult", "logit") {
	di as error "link() option must be one of identity, logadd, logmult, or logit"
	error 198
}

local endogcount = wordcount("`endog'")
if `endogcount' != 1 {
	di as error "Currently, only 1 endogenous variable is allowed"
	error 198
}

// stage 1
tempname stage1b stage2b from
qui regress `endog' `inst' `exog' `if'`in'
mat `stage1b' = e(b)
tempvar stage1res
predict `stage1res' `if'`in', residuals
 


if "`link'" == "identity" {

}

if "`link'" == "logadd" {

}

if "`link'" == "logmult" {

}

if "`link'" == "logit" {
	// fit stage 2 logistic regression to obtain initial values
	qui logit `lhs' `endog' `stage1res' `exog' `if'`in'
	mat `stage2b' = e(b)
	mat `from' = (`stage1b', `stage2b')

	if "`estonly'" == "" {
		if "`exog'" != "" {
			local s2exogexpr "+ {s2exogxb:`exog'}"
		}

		gmm (`endog' - ({s1xb:`inst' `exog'}) - {a0}) ///
			(`lhs' - invlogit({b1}*`endog' + {b2}*(`endog' - ({s1xb:}) - {a0}) `s2exogexpr' + {b0})) ///
			`if'`in', ///
			instruments(1:`inst' `exog') ///
			instruments(2:`endog' `stage1res' `exog') ///
			winitial(unadjusted, independent) ///
			from(`from') ///
			`options'
	}
}

ereturn local link `link'
ereturn local estonly `estonly'

end


program Display, rclass
version 10
syntax [anything] [, Level(cilevel) ///
	lhs(varname) endog(varlist) exog(varlist) inst(varlist) ///
	replay(integer 0) Link(string) estonly]

if `replay' == 1 | "`estonly'" != "" {
	display
	_coef_table , level(`level')
}
else {
	qui _coef_table , level(`level') // to return r(table)
}

return add

if "`link'" == "identity" local parameter "Causal risk difference"
if inlist("`link'", "logadd", "logmult") local parameter "Causal risk ratio"
if "`link'" == "logit" local parameter "Causal odds ratio"


foreach par in b1 b2 {
	di _n as txt "`parameter' for: `par'"
	lincom /`par', eform
}

end
