// ivxtile cscript
// 2021-09-16

cscript ivxtile adofiles ivxtile

// burgess, davies, thompson paper simulations (y1-y5)

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
gen y6 = -.1*x^2
gen y7 = (x - 5)^2

discard
ivxtile, nq(4) par(b1): ivtsps y2 (x = g)

ivxtile, nq(4) par(b1) trace: ivtsps y2 (x = g)

ivxtile, nq(10) par(b1): ivtsps y2 (x = g)

ivxtile, nq(4) par(b1): ivtsps y2 (x = g), link(identity)

ivxtile, nq(4) par(b1): ivtsri y2 (x = g)
ivxtile, nq(4) par(b1): ivtsri y2 (x = g), link(identity)

ivxtile, nq(4) par(x): ivregress 2sls y2 (x = g)
ivxtile, nq(4) par(x): ivregress liml y2 (x = g)
ivxtile, nq(4) par(x): ivregress gmm y2 (x = g)

ivxtile, nq(4) par(x): ivreg2 y2 (x = g)

// binary data for other link functions

clear all
set obs 4000
set seed 12345
gen z1 = rbinomial(2, .2)
gen z2 = rbinomial(2, .3)
gen z3 = rbinomial(2, .4)
gen u = rnormal()
gen w = rnormal()
gen x1 = z1 + z2 + z3 + w + u + rnormal()
gen x = x1
gen x2 = z1 + z2 + u + rnormal()
gen logitpy = -2 + .1*x1^2 + 0.5*x2 + w + u
gen py = invlogit(logitpy)
gen y = rbinomial(1, py)

twoway line logitpy x1, sort(x1)

ivxtile, nq(4) par(b1): ivtsps y (x = z1 z2 z3), link(logadd)
ivxtile, nq(4) par(b1): ivtsps y (x = z1 z2 z3), link(logmult)
ivxtile, nq(4) par(b1): ivtsps y (x = z1 z2 z3), link(logit)

ivxtile, nq(4) par(b1): ivtsri y (x = z1 z2 z3), link(logadd)
ivxtile, nq(4) par(b1): ivtsri y (x = z1 z2 z3), link(logmult) 
ivxtile, nq(4) par(b1): ivtsri y (x = z1 z2 z3), link(logit)

ivxtile, nq(4) par(x): ivmsmm y (x = z1 z2 z3)

ivxtile, nq(4) par(x): ivlsmm y (x = z1 z2 z3)
