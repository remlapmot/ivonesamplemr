// ivtsps cscript
// 2021-09-06

cscript ivtsps adofiles ivtsps

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
ivtsps y (x = z1 z2 z3)
ivtsps
assert abs(_b[b1:_cons] - scalar(bx1)) < 1e-2
assert abs(_se[b1:_cons] - scalar(sx1)) < 1e-3

ivregress gmm y (x = z1 z2 z3) if _n <= 50
scalar bx2 = _b[x]
scalar sx2 = _se[x]
ivtsps y (x = z1 z2 z3) if _n <= 50
assert abs(_b[b1:_cons] - scalar(bx2)) < 1e-2
assert abs(_se[b1:_cons] - scalar(sx2)) < 1e-3

ivtsps y (x = z1 z2 z3), link(identity)
assert abs(_b[b1:_cons] - scalar(bx1)) < 1e-2
assert abs(_se[b1:_cons] - scalar(sx1)) < 1e-3

ivregress gmm y w (x = z1 z2 z3)
scalar bx3 = _b[x]
scalar sx3 = _se[x]
ivtsps y w (x = z1 z2 z3), link(identity)
assert abs(_b[b1:_cons] - scalar(bx3)) < 1e-2
assert abs(_se[b1:_cons] - scalar(sx3)) < 1e-3

ivtsps y (x = z1 z2 z3), estonly
ivtsps
mat b = e(b)
assert abs(b[1,1] - scalar(bx1)) < 1e-2

// logadd link

ivpoisson gmm y (x = z1 z2 z3), add
scalar lrr1 = _b[x]
scalar selrr1 = _se[x]
ivtsps y (x = z1 z2 z3), link(logadd)
ivtsps
assert abs(_b[b1:_cons] - scalar(lrr1)) < 1e-2
assert abs(_se[b1:_cons] - scalar(selrr1)) < 1e-2

ivpoisson gmm y (x = z1 z2 z3) if _n <= 200, add
scalar lrr2 = _b[x]
scalar selrr2 = _se[x]
ivtsps y (x = z1 z2 z3) if _n <= 200, link(logadd)
assert abs(_b[b1:_cons] - scalar(lrr2)) < 1e-2
assert abs(_se[b1:_cons] - scalar(selrr2)) < 1e-2

ivpoisson gmm y w (x = z1 z2 z3), add
scalar lrr3 = _b[x]
scalar selrr3 = _se[x]
ivtsps y w (x = z1 z2 z3), link(logadd)
assert abs(_b[b1:_cons] - scalar(lrr3)) < 1e-2
assert abs(_se[b1:_cons] - scalar(selrr3)) < 1e-2

ivtsps y (x = z1 z2 z3), link(logadd) estonly
ivtsps
mat b = e(b)
assert abs(b[1,1] - scalar(lrr1)) < 1e-2

// logmult link

cap noi drop pred
regress x z1 z2 z3
predict pred
glm y pred, family(gamma) link(log)
scalar lmrr1 = _b[pred]
scalar selmrr1 = _se[pred]
ivtsps y (x = z1 z2 z3), link(logmult)
ivtsps
assert abs(_b[b1:_cons] - scalar(lmrr1)) < 1e-2
assert abs(_se[b1:_cons] - scalar(selmrr1)) < 1e-2

cap noi drop pred
regress x z1 z2 z3 if _n <= 250
predict pred if _n <= 250
glm y pred if _n <= 250, family(gamma) link(log)
scalar lmrr2 = _b[pred]
scalar selmrr2 = _se[pred]
ivtsps y (x = z1 z2 z3) if _n <= 250, link(logmult)
assert abs(_b[b1:_cons] - scalar(lmrr2)) < 1e-2
assert abs(_se[b1:_cons] - scalar(selmrr2)) < 2e-2

cap noi drop pred
regress x z1 z2 z3 w
predict pred
glm y pred w, family(gamma) link(log)
scalar lmrr3 = _b[pred]
scalar selmrr3 = _se[pred]
ivtsps y w (x = z1 z2 z3), link(logmult)
assert abs(_b[b1:_cons] - scalar(lmrr3)) < 1e-2
assert abs(_se[b1:_cons] - scalar(selmrr3)) < 1e-2

ivtsps y (x = z1 z2 z3), link(logmult) estonly
ivtsps
mat b = e(b)
assert abs(b[1,1] - scalar(lmrr1)) < 1e-2

// logit link

cap noi drop pred
regress x z1 z2 z3
predict pred
logit y pred
scalar lor1 = _b[pred]
scalar selor1 = _se[pred]
ivtsps y (x = z1 z2 z3), link(logit)
ivtsps
assert abs(_b[b1:_cons] - scalar(lor1)) < 1e-2
assert abs(_se[b1:_cons] - scalar(selor1)) < 1e-2

cap noi drop pred
regress x z1 z2 z3 if _n <= 100
predict pred if _n <= 100
logit y pred if _n <= 100
scalar lor2 = _b[pred]
scalar selor2 = _se[pred]
ivtsps y (x = z1 z2 z3) if _n <= 100, link(logit)
assert abs(_b[b1:_cons] - scalar(lor2)) < 1e-2
assert abs(_se[b1:_cons] - scalar(selor2)) < 1e-1

cap noi drop pred
regress x w z1 z2 z3
predict pred
logit y w pred
scalar lor3 = _b[pred]
scalar selor3 = _se[pred]
ivtsps y w (x = z1 z2 z3), link(logit)
assert abs(_b[b1:_cons] - scalar(lor3)) < 1e-2
assert abs(_se[b1:_cons] - scalar(selor3)) < 1e-2

ivtsps y (x = z1 z2 z3), link(logit) estonly
ivtsps
mat b = e(b)
assert abs(b[1,1] - scalar(lor1)) < 1e-2

// check errors

rcof "noi ivtsps y w (x1 x2 = z1 z2 z3)" == 198
