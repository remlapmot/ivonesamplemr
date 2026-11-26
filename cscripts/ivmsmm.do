// ivmsmm cscript
// 2021-09-01

cscript ivmsmm adofiles ivmsmm
set varabbrev off

about

// simulate data
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
gen x1 = x
gen x2 = rnormal()

// tests

ivmsmm y (x = z1)
assert abs(_b[x] - .328) < 1e-3
ivpoisson, irr

mat list r(table)

ivmsmm y (x = z1 z2 z3)
assert abs(_b[x] - .297) < 1e-3
cap noi estat overid
ivpoisson, irr

// overid test
estat overid
assert abs(r(J) - 1.161) < 1e-3
assert r(J_df) == 2
assert abs(r(J_p) - .56) < 1e-2

// ivpoisson helpfile
webuse trip, clear

* Generalized method of moments: multiplicative errors
ivpoisson gmm trips cbd ptn worker weekend (tcost=pt), multiplicative
assert abs(_b[tcost] - .035) < 1e-3
ivpoisson, irr

ivmsmm trips cbd ptn worker weekend (tcost=pt)
assert abs(_b[tcost] - .035) < 1e-3

// estmethod() option
clear
set obs 1000
set seed 12345
gen z = rbinomial(1, .5)
gen u = runiform()
gen x = rbinomial(1, .2 + .5*z)
gen y = rbinomial(1, invlogit(-1 + .5*x + u))

// gmmalt is the default and is the same as ivpoisson
ivmsmm y (x = z)
local b_default = _b[x]
ivmsmm y (x = z), estmethod(gmmalt)
assert reldif(_b[x], `b_default') < 1e-8
assert "`e(estmethod)'" == "gmmalt"

// with a single instrument all the methods solve the same estimating equation
ivmsmm y (x = z), estmethod(gmm)
assert "`e(estmethod)'" == "gmm"
assert reldif(_b[/xb_x], `b_default') < 1e-4
ivmsmm y (x = z), estmethod(tsls)
assert reldif(log(e(crr)), `b_default') < 1e-4
ivmsmm y (x = z), estmethod(tslsalt)
assert reldif(log(e(crr)), `b_default') < 1e-4

// error messages
rcof "ivmsmm y (x = z), estmethod(foo)" == 198
gen w = rnormal()
rcof "ivmsmm y w (x = z), estmethod(tsls)" == 198
gen xc = rnormal()
rcof "ivmsmm y (xc = z), estmethod(tsls)" == 450
