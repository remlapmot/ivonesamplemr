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
// ivmw: ivregress 2sls y (x = z1 z2 z3)

// ivreg2
ivmw, window(2490) par(x): ivreg2 y (x = z1 z2 z3)
ivmw, window(90) par(x): ivreg2 y (x = z1 z2 z3) in 1/100

// ivlsmm
ivmw, window(2490) par(x): ivlsmm y (x = z1 z2 z3)

// ivmsmm
ivmw, window(2490) par(x): ivmsmm y (x = z1 z2 z3)

// ivtsps
ivmw, window(2490) par(b1): ivtsps y (x = z1 z2 z3)
ivmw, window(2490) par(b1): ivtsps y (x = z1 z2 z3), link(logadd)
ivmw, window(2490) par(b1): ivtsps y (x = z1 z2 z3), link(logmult)
ivmw, window(2490) par(b1): ivtsps y (x = z1 z2 z3), link(logit)

// ivtsri
ivmw, window(2490) par(b1): ivtsri y (x = z1 z2 z3)
ivmw, window(2490) par(b1): ivtsri y (x = z1 z2 z3), link(logadd)
ivmw, window(2490) par(b1): ivtsri y (x = z1 z2 z3), link(logmult)
ivmw, window(2490) par(b1): ivtsri y (x = z1 z2 z3), link(logit)

// try quadratic exposure
clear
set obs 2500
set seed 12345
gen z1 = rbinomial(2, .2)
gen z2 = rbinomial(2, .3)
gen z3 = rbinomial(2, .4)
gen u = rnormal()
gen x = z1 + z2 + z3 + u + rnormal()
gen logitpy = -6 + x^2 + u
gen py = invlogit(logitpy)
replace py = 0.99 if py == 1
gen y = rbinomial(1, py)

ivmw, window(2480) par(x): ivreg2 y (x = z1 z2 z3)

clear
set obs 2500
set seed 12345
gen z1 = rbinomial(2, .2)
gen z2 = rbinomial(2, .3)
gen z3 = rbinomial(2, .4)
gen u = rnormal()
gen x = z1 + z2 + z3 + u + rnormal()
gen logitpy = -6 + x^2 + u
gen py = invlogit(logitpy)
replace py = 0.99 if py == 1
gen y = rbinomial(1, py)

ivmw, window(2480) par(x): ivmsmm y (x = z1 z2 z3)

// burgess, davies, thompson paper simulations

clear
set obs 4000
set seed 12345
gen g = rbinomial(2, .3)
gen u = runiform()
gen ex = rexponential(1)
gen x = .25*g + u + ex
gen ey = rnormal()
gen y1 = .4*x + .8*u + ey
gen y2 = .1*x^2
gen y3 = .2*(x - 1)^2
gen y4 = .3*(x - 2)^2
gen y5 = max(x - 2, 0)

twoway line y1 x, sort(x)
twoway line y2 y3 y4 x, sort(x)
twoway line y5 x, sort(x)

ivmw, window(3550) par(x): ivreg2 y1 (x = g)
ivmw, window(3550) par(x): ivreg2 y2 (x = g)
ivmw, window(3550) par(x): ivreg2 y3 (x = g)
ivmw, window(3550) par(x): ivreg2 y4 (x = g)
ivmw, window(3550) par(x): ivreg2 y5 (x = g)
