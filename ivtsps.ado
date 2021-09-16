*! 1.0.0 Tom Palmer 05sep2021
program ivtsps, eclass

if _caller() >= 11 {
    local vv : di "version " string(_caller()) ":"
}
version 10

local replay = replay()

if replay() {
    if `"`e(cmd)'"' != "ivtsps" { 
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

ereturn local cmd "ivtsps"
ereturn local cmdline `"ivtsps `0'"'
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
cap ds predicted
if _rc == 0 {
	local predictedreplace 1
	tempvar predicted
	qui gen `predicted' = predicted
	qui drop predicted
}
else local predictedreplace 0
qui predict predicted `if'`in'

if "`link'" == "identity" {
	// fit stage 2 linear regression to obtain initial values
	qui regress `lhs' predicted `exog' `if'`in'
	mat `stage2b' = e(b)
	mat `from' = (`stage1b', `stage2b')

	if "`estonly'" == "" {
		if "`exog'" != "" {
			local s2exogexpr "+ {s2exogxb:`exog'}"
		}

		gmm (`endog' - ({s1xb:`inst' `exog'}) - {a0}) ///
			(`lhs' - ({b1}*({s1xb:} + {a0}) `s2exogexpr' + {b0})) ///
			`if'`in', ///
			instruments(1:`inst' `exog') ///
			instruments(2:predicted `exog') ///
			winitial(unadjusted, independent) ///
			from(`from') ///
			`options' nolog onestep
	}
}

if "`link'" == "logadd" {
	// fit stage 2 poisson regression to obtain initial values
	// nb. for binary should be log-binomial regression, but poisson possibly safer if multi-category outcome
	qui glm `lhs' predicted `exog' `if'`in', family(poisson) link(log)
	mat `stage2b' = e(b)
	mat `from' = (`stage1b', `stage2b')

	if "`estonly'" == "" {
		if "`exog'" != "" {
			local s2exogexpr "+ {s2exogxb:`exog'}"
		}

		gmm (`endog' - ({s1xb:`inst' `exog'}) - {a0}) ///
			(`lhs' - exp({b1}*({s1xb:} + {a0}) `s2exogexpr' + {b0})) ///
			`if'`in', ///
			instruments(1:`inst' `exog') ///
			instruments(2:predicted `exog') ///
			winitial(unadjusted, independent) ///
			from(`from') ///
			`options' nolog onestep
	}
}

if "`link'" == "logmult" {
	// fit stage 2 gamma regression to obtain initial values
	qui glm `lhs' predicted `exog' `if'`in', family(gamma) link(log)
	mat `stage2b' = e(b)
	mat `from' = (`stage1b', `stage2b')

	if "`estonly'" == "" {
		if "`exog'" != "" {
			local s2exogexpr "+ {s2exogxb:`exog'}"
		}

		gmm (`endog' - ({s1xb:`inst' `exog'}) - {a0}) ///
			(`lhs' * exp(-1 * ({b1}*({s1xb:} + {a0}) `s2exogexpr' + {b0})) - 1) ///
			`if'`in', ///
			instruments(1:`inst' `exog') ///
			instruments(2:predicted `exog') ///
			winitial(unadjusted, independent) ///
			from(`from') ///
			`options' nolog onestep
	}
}

if "`link'" == "logit" {
	// fit stage 2 logistic regression to obtain initial values
	qui logit `lhs' predicted `exog' `if'`in'
	mat `stage2b' = e(b)
	mat `from' = (`stage1b', `stage2b')

	if "`estonly'" == "" {
		if "`exog'" != "" {
			local s2exogexpr "+ {s2exogxb:`exog'}"
		}

		gmm (`endog' - ({s1xb:`inst' `exog'}) - {a0}) ///
			(`lhs' - invlogit({b1}*({s1xb:} + {a0}) `s2exogexpr' + {b0})) ///
			`if'`in', ///
			instruments(1:`inst' `exog') ///
			instruments(2:predicted `exog') ///
			winitial(unadjusted, independent) ///
			from(`from') ///
			`options' nolog onestep
	}
}

if `predictedreplace' == 1 qui replace predicted = `predicted'
else qui drop predicted

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

return add // to return r(table)

local eformopt ", eform"

if "`link'" == "identity" {
	local parameter "Causal risk difference"
	local eformopt ""
}
if inlist("`link'", "logadd", "logmult") local parameter "Causal risk ratio"
if "`link'" == "logit" local parameter "Causal odds ratio"

if "`estonly'" == "" {
	foreach par in b1 {
		di _n as txt "`parameter' for: `par'"
		lincom /`par' `eformopt'
	}
}

end
