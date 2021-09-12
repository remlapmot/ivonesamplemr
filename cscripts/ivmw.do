// ivmw cscript
// 2021-09-12

cscript ivmw adofiles ivmw

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

// ivregress
ivmw: ivregress 2sls y (x = z1 z2 z3)

// ivreg2
ivmw: ivreg2 y (x = z1 z2 z3)
ivmw, window(100): ivreg2 y (x = z1 z2 z3)

// ivlsmm
ivmw: ivlsmm y (x = z1 z2 z3)

// ivmsmm
ivmw: ivmsmm y (x = z1 z2 z3)

// ivtsps
ivmw: ivtsps y (x = z1 z2 z3)
ivmw: ivtsps y (x = z1 z2 z3), link(logadd)
ivmw: ivtsps y (x = z1 z2 z3), link(logmult)
ivmw: ivtsps y (x = z1 z2 z3), link(logit)

// ivtsri
ivmw: ivtsri y (x = z1 z2 z3)
ivmw: ivtsri y (x = z1 z2 z3), link(logadd)
ivmw: ivtsri y (x = z1 z2 z3), link(logmult)
ivmw: ivtsri y (x = z1 z2 z3), link(logit)

