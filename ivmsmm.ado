*! 1.1.0 Tom Palmer 23nov2026
program ivmsmm, eclass
version 13 // ivpoisson was introduced in Stata 13

syntax anything(equalok) [if] [in] [aw fw iw pw] ///
    [, noIRR LOG ESTMethod(string) Level(cilevel) *]

if "`estmethod'" == "" local estmethod "gmmalt"
if !inlist("`estmethod'", "gmm", "gmmalt", "tsls", "tslsalt") {
    di as error "estmethod() must be one of gmm, gmmalt, tsls, or tslsalt"
    exit 198
}

if "`weight'" != "" local wgt [`weight'`exp']
if "`log'" == "" local nolog "nolog"
else local nolog ""

// alternative moment conditions, which are those fitted by ivpoisson
if "`estmethod'" == "gmmalt" {
    if "`irr'" == "" local irropt "irr"
    ivpoisson gmm `anything' `if' `in' `wgt', multiplicative `nolog' ///
        `irropt' level(`level') `options'
    ereturn local estmethod "gmmalt"
    exit
}

_iv_parse `anything'
local lhs `s(lhs)'
local endog `s(endog)'
local exog `s(exog)'
local inst `s(inst)'

marksample touse
markout `touse' `lhs' `endog' `exog' `inst'

// moment conditions E[(1, Z')' {Y exp(-psi X) - E[Y(0)]}] = 0
if "`estmethod'" == "gmm" {
    gmm (`lhs'*exp(-{xb:`endog' `exog'}) - {ey0}) if `touse' `wgt', ///
        instruments(`inst' `exog') winitial(identity) center `nolog' level(`level') `options'
    ereturn local estmethod "gmm"
    ereturn local endog `endog'
    ereturn local exog `exog'

    if "`irr'" == "" {
        foreach var of local endog {
            di _n as txt "Causal risk ratio for: `var'"
            lincom /xb_`var', eform level(`level')
        }
    }
    exit
}

// two-stage least squares methods for a binary outcome and exposure
local nendog : word count `endog'
if `nendog' != 1 {
    di as error "With estmethod(tsls) and estmethod(tslsalt), only 1 endogenous variable is allowed"
    exit 198
}
if "`exog'" != "" {
    di as error "Covariates are not supported with estmethod(tsls) and estmethod(tslsalt)"
    exit 198
}
capture assert inlist(`lhs', 0, 1) if `touse'
if _rc {
    di as error "With estmethod(tsls) and estmethod(tslsalt), the outcome must be binary, i.e. take values 0 or 1"
    exit 450
}
capture assert inlist(`endog', 0, 1) if `touse'
if _rc {
    di as error "With estmethod(tsls) and estmethod(tslsalt), the exposure must be binary, i.e. take values 0 or 1"
    exit 450
}

tempvar outcome exposure
if "`estmethod'" == "tsls" {
    qui gen double `outcome' = `lhs' * (1 - `endog') if `touse'
    qui gen double `exposure' = `lhs' * `endog' if `touse'
}
else {
    qui gen double `outcome' = `lhs' * `endog' if `touse'
    qui gen double `exposure' = `lhs' * (1 - `endog') if `touse'
}

qui ivregress 2sls `outcome' (`exposure' = `inst') if `touse' `wgt', ///
    small level(`level') `options'

// log causal risk ratio and its delta method standard error
tempname b se z crr lb ub
scalar `b' = _b[`exposure']
scalar `se' = _se[`exposure'] / abs(`b')
if "`estmethod'" == "tsls" {
    scalar `crr' = -1 / `b'
}
else {
    scalar `crr' = -1 * `b'
}
scalar `z' = invnormal(1 - (100 - `level') / 200)
scalar `lb' = exp(log(`crr') - `z' * `se')
scalar `ub' = exp(log(`crr') + `z' * `se')

di _n as txt "Multiplicative structural mean model, " ///
    "two-stage least squares method (estmethod(`estmethod'))"
di as txt "Number of obs = " as res e(N)
if "`estmethod'" == "tsls" {
    tempname t
    scalar `t' = invttail(e(df_r), (100 - `level') / 200)
    di _n as txt "E[Y(0)]: " as res %9.0g _b[_cons] ///
        as txt "  [`level'% CI: " as res %9.0g _b[_cons] - `t' * _se[_cons] ///
        as txt ", " as res %9.0g _b[_cons] + `t' * _se[_cons] as txt "]"
}
di _n as txt "Causal risk ratio for: `endog'"
di as txt "CRR = " as res %9.0g `crr' ///
    as txt "  [`level'% CI: " as res %9.0g `lb' as txt ", " as res %9.0g `ub' as txt "]"

ereturn local estmethod "`estmethod'"
ereturn local endog `endog'
ereturn scalar crr = `crr'
ereturn scalar crr_lb = `lb'
ereturn scalar crr_ub = `ub'
ereturn scalar logcrr_se = `se'
end
exit
