// ivmsmm cscript
// 2021-09-01

cscript ivmsmm adofiles ivmsmm

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

ivmsmm y (x = z1 z2 z3)
assert abs(_b[x] - .297) < 1e-3
cap noi estat overid
ivpoisson, irr

estat overid

// ivpoisson helpfile
webuse trip, clear

* Generalized method of moments: multiplicative errors
ivpoisson gmm trips cbd ptn worker weekend (tcost=pt), multiplicative
assert abs(_b[tcost] - .035) < 1e-3
ivpoisson, irr

ivmsmm trips cbd ptn worker weekend (tcost=pt)
assert abs(_b[tcost] - .035) < 1e-3
