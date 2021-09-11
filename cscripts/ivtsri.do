// ivtsri cscript
// 2021-09-06

cscript ivtsri adofiles ivtsri

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

// identity link

ivregress gmm y (x = z1 z2 z3)
scalar bx1 = _b[x]
scalar sx1 = _se[x]
estat endog
scalar endogteststat = r(C)
ivtsri y (x = z1 z2 z3)
ivtsri
assert abs(_b[b1:_cons] - scalar(bx1)) < 1e-2
assert abs(_se[b1:_cons] - scalar(sx1)) < 1e-3
assert abs((_b[b2:_cons] / _se[b2:_cons])^2 - scalar(endogteststat)) < 1e0
mat list r(table)

ivregress gmm y (x = z1 z2 z3) if _n <= 50
scalar bx2 = _b[x]
scalar sx2 = _se[x]
ivtsri y (x = z1 z2 z3) if _n <= 50
assert abs(_b[b1:_cons] - scalar(bx2)) < 1e-2
assert abs(_se[b1:_cons] - scalar(sx2)) < 1e-3

ivtsri y (x = z1 z2 z3), link(identity)
assert abs(_b[b1:_cons] - scalar(bx1)) < 1e-2
assert abs(_se[b1:_cons] - scalar(sx1)) < 1e-3

ivregress gmm y w (x = z1 z2 z3)
scalar bx3 = _b[x]
scalar sx3 = _se[x]
ivtsri y w (x = z1 z2 z3), link(identity)
assert abs(_b[b1:_cons] - scalar(bx3)) < 1e-2
assert abs(_se[b1:_cons] - scalar(sx3)) < 1e-3

ivtsri y (x = z1 z2 z3), estonly
ivtsri
mat b = e(b)
assert abs(b[1,1] - scalar(bx1)) < 1e-2

// logadd link

cap noi drop res
regress x z1 z2 z3
predict double res, res
poisson y x res, nolog
scalar larr1 = _b[x]
scalar selarr1 = _se[x]
ivtsri y (x = z1 z2 z3), link(logadd)
ivtsri
assert abs(_b[b1:_cons] - scalar(larr1)) < 1e-2
assert abs(_se[b1:_cons] - scalar(selarr1)) < 1e-2
mat list r(table)

cap noi drop res
regress x z1 z2 z3 if _n <= 200
predict double res if _n <= 200, res
poisson y x res if _n <= 200, nolog
scalar larr2 = _b[x]
scalar selarr2 = _se[x]
ivtsri y (x = z1 z2 z3) if _n <= 200, link(logadd)
assert abs(_b[b1:_cons] - scalar(larr2)) < 1e-2
assert abs(_se[b1:_cons] - scalar(selarr2)) < 1e-1

cap noi drop res
regress x z1 z2 z3 w
predict double res, res
poisson y x res w, nolog
scalar larr3 = _b[x]
scalar selarr3 = _se[x]
ivtsri y w (x = z1 z2 z3), link(logadd)
assert abs(_b[b1:_cons] - scalar(larr3)) < 1e-2
assert abs(_se[b1:_cons] - scalar(selarr3)) < 5e-2

ivtsri y (x = z1 z2 z3), link(logadd) estonly
ivtsri
mat b = e(b)
assert abs(b[1,1] - scalar(larr1)) < 1e-2

// logmult link

ivpoisson cfunction y (x = z1 z2 z3), nolog
scalar lmrr1 = _b[x]
scalar selmrr1 = _se[x]
ivtsri y (x = z1 z2 z3), link(logmult)
ivtsri
assert abs(_b[b1:_cons] - scalar(lmrr1)) < 1e-2
assert abs(_se[b1:_cons] - scalar(selmrr1)) < 1e-2
mat list r(table)

ivpoisson cfunction y (x = z1 z2 z3) if _n <= 250, nolog
scalar lmrr2 = _b[x]
scalar selmrr2 = _se[x]
ivtsri y (x = z1 z2 z3) if _n <= 250, link(logmult)
assert abs(_b[b1:_cons] - scalar(lmrr2)) < 1e-2
assert abs(_se[b1:_cons] - scalar(selmrr2)) < 1e-2

ivpoisson cfunction y w (x = z1 z2 z3), nolog
scalar lmrr3 = _b[x]
scalar selmrr3 = _se[x]
ivtsri y w (x = z1 z2 z3), link(logmult)
assert abs(_b[b1:_cons] - scalar(lmrr3)) < 1e-2
assert abs(_se[b1:_cons] - scalar(selmrr3)) < 1e-2

ivtsri y (x = z1 z2 z3), link(logmult) estonly
ivtsri
mat b = e(b)
assert abs(b[1,1] - scalar(lmrr1)) < 1e-2

// logit link

cap noi drop res
regress x z1 z2 z3
predict double res, res
logit y x res, nolog
scalar lor1 = _b[x]
scalar selor1 = _se[x]
ivtsri y (x = z1 z2 z3), link(logit)
ivtsri
assert abs(_b[b1:_cons] - scalar(lor1)) < 1e-2
assert abs(_se[b1:_cons] - scalar(selor1)) < 1e-2
mat list r(table)

cap noi drop res
regress x z1 z2 z3 if _n <= 100
predict double res if _n <= 100, res
logit y x res if _n <= 100, nolog
scalar lor2 = _b[x]
scalar selor2 = _se[x]
ivtsri y (x = z1 z2 z3) if _n <= 100, link(logit)
assert abs(_b[b1:_cons] - scalar(lor2)) < 1e-2
assert abs(_se[b1:_cons] - scalar(selor2)) < 5e-2

cap noi drop res
regress x z1 z2 z3 w
predict double res, res
logit y x res w, nolog
scalar lor3 = _b[x]
scalar selor3 = _se[x]
ivtsri y w (x = z1 z2 z3), link(logit)
assert abs(_b[b1:_cons] - scalar(lor3)) < 1e-2
assert abs(_se[b1:_cons] - scalar(selor3)) < 1e-2

ivtsri y (x = z1 z2 z3), link(logit) estonly
ivtsri
mat b = e(b)
assert abs(b[1,1] - scalar(lor1)) < 1e-2

// check errors

rcof "noi ivtsri y w (x1 x2 = z1 z2 z3)" == 198

// residuals varname test

cap noi drop residuals
regress x z1 z2 z3
predict residuals, residuals
regress y x residuals
scalar bx4 = _b[x]
scalar sx4 = _se[x]
scalar bxr = _b[residuals]
scalar sxr = _se[residuals]
replace residuals = _n in 1/3
list residuals in 1/5
ivtsri y (x = z1 z2 z3)
assert abs(_b[b1:_cons] - scalar(bx4)) < 1e-2
assert abs(_b[b2:_cons] - scalar(bxr)) < 1e-2
list residuals in 1/5

cap noi drop residuals
regress x z1 z2 z3 in 101/200
predict residuals in 101/200, residuals
regress y x residuals in 101/200
scalar bx4 = _b[x]
scalar sx4 = _se[x]
scalar bxr = _b[residuals]
scalar sxr = _se[residuals]
replace residuals = _n in 1/3
list residuals in 1/5
ivtsri y (x = z1 z2 z3) in 101/200
assert abs(_b[b1:_cons] - scalar(bx4)) < 1e-2
assert abs(_b[b2:_cons] - scalar(bxr)) < 1e-2
list residuals in 1/5
