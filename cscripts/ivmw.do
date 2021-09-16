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
ivmw, window(2490) par(x): ivregress 2sls y (x = z1 z2 z3)
ivmw, window(2490) par(x): ivregress liml y (x = z1 z2 z3)
ivmw, window(2490) par(x): ivregress gmm y (x = z1 z2 z3)

// ivreg2
ivmw, window(2490) par(x): ivreg2 y (x = z1 z2 z3)
ivmw, window(90) par(x): ivreg2 y (x = z1 z2 z3) in 1/100

// ivtsps
ivmw, window(2490) par(b1): ivtsps y (x = z1 z2 z3)
ivmw, window(2490) par(b1): ivtsps y (x = z1 z2 z3), link(identity)

// ivtsri
ivmw, window(2490) par(b1): ivtsri y (x = z1 z2 z3)
ivmw, window(2490) par(b1): ivtsri y (x = z1 z2 z3), link(identity)


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

twoway line y1 x, sort(x)
twoway line y2 y3 y4 x, sort(x)
twoway line y5 x, sort(x)
twoway line y6 y7 x, sort(x)

ivmw, window(3976) par(x): ivreg2 y1 (x = g)
ivmw, window(3976) par(x): ivreg2 y2 (x = g)
ivmw, window(3976) par(x): ivreg2 y3 (x = g)
ivmw, window(3976) par(x): ivreg2 y4 (x = g)
ivmw, window(3976) par(x): ivreg2 y5 (x = g)
ivmw, window(3976) par(x): ivreg2 y6 (x = g)
ivmw, window(3976) par(x): ivreg2 y7 (x = g)

ivmw, window(476) par(x): ivreg2 y2 (x = g) in 1/500

ivmw, window(3950) par(x) saving(ivmw, replace): ivreg2 y2 (x = g)
use ivmw, clear
list in 1/5
clear
if c(os) == "Windows" erase ivmw.dta
else rm ivmw.dta

// binary data for logadd, logmult, logit links

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
gen logitpy = -2 + x1 + 0.5*x2 + w + u
gen py = invlogit(logitpy)
gen y = rbinomial(1, py)

ivmw, window(3991) par(x): ivlsmm y (x = z1 z2 z3)
ivmw, window(3991) par(x): ivmsmm y (x = z1 z2 z3)
ivmw, window(3991) par(b1): ivtsps y (x = z1 z2 z3), link(logadd)
ivmw, window(3991) par(b1): ivtsps y (x = z1 z2 z3), link(logmult)
ivmw, window(3991) par(b1): ivtsps y (x = z1 z2 z3), link(logit)
ivmw, window(3991) par(b1): ivtsri y (x = z1 z2 z3), link(logadd)
ivmw, window(3991) par(b1): ivtsri y (x = z1 z2 z3), link(logmult)
ivmw, window(3991) par(b1): ivtsri y (x = z1 z2 z3), link(logit)
