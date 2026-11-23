*! 1.0.0 Tom Palmer 23nov2026
program ivfsw, rclass
version 11

// postestimation command after ivregress or ivreg2: the endogenous
// variables, included exogenous variables, and excluded instruments are taken
// from the estimation results
if !inlist("`e(cmd)'", "ivregress", "ivreg2") {
    di as error "ivfsw requires the results of {cmd:ivregress} or {cmd:ivreg2}"
    exit 301
}

syntax

local endog `e(instd)'
if "`e(cmd)'" == "ivregress" {
    local exog `e(exogr)'
    local allinst `e(insts)'
    local inst : list allinst - exog
}
else {
    local exog `e(inexog)'
    local inst `e(exexog)'
}

local K : word count `endog'
local L : word count `inst'
if `L' < `K' {
    di as error "there must be at least as many excluded instruments as endogenous variables"
    exit 481
}

tempvar touse condres
qui gen byte `touse' = e(sample)
tempname table
mat `table' = J(`K', 4, .)
mat rownames `table' = `endog'
mat colnames `table' = F df df_r p

preserve
local i = 0
foreach x of local endog {
    local ++i
    local others : list endog - x
    // conditional model: the endogenous variable regressed on the other
    // endogenous variables and the exogenous variables, with the other
    // endogenous variables instrumented by the excluded instruments
    if "`others'" == "" {
        qui regress `x' `exog' if `touse'
    }
    else {
        qui ivregress 2sls `x' `exog' (`others' = `inst') if `touse'
    }
    qui predict double `condres' if `touse', residuals
    // F-test of the excluded instruments in the regression of the
    // conditional model residuals on the instruments and exogenous variables
    qui regress `condres' `inst' `exog' if `touse'
    qui test `inst'
    // Sanderson-Windmeijer conditional F-statistic
    local df = r(df) - (`K' - 1)
    local fsw = r(F) * r(df) / `df'
    mat `table'[`i', 1] = `fsw'
    mat `table'[`i', 2] = `df'
    mat `table'[`i', 3] = r(df_r)
    mat `table'[`i', 4] = Ftail(`df', r(df_r), `fsw')
    drop `condres'
}
restore

di _n as txt "Sanderson-Windmeijer conditional F-statistics"
di as txt "Number of obs = " as res e(N)
di _n as txt %-14s "Variable" _col(16) %10s "F" %8s "df" %10s "df_r" %10s "P>F"
di as txt "{hline 54}"
local i = 0
foreach x of local endog {
    local ++i
    di as txt %-14s abbrev("`x'", 14) _col(16) as res %10.2f `table'[`i', 1] ///
        %8.0f `table'[`i', 2] %10.0f `table'[`i', 3] %10.4f `table'[`i', 4]
}

return matrix table = `table'
return scalar N = e(N)
return scalar K = `K'
return scalar L = `L'
end
exit
