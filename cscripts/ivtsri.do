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

cap noi {
ivtsri y (x = z1 z2 z3), link(logadd)
ivtsri

ivtsri y (x = z1 z2 z3) if _n <= 200, link(logadd)

ivtsri y w (x = z1 z2 z3), link(logadd)

ivtsri y (x = z1 z2 z3), link(logadd) estonly
ivtsri
}

// logmult link

cap noi {
ivtsri y (x = z1 z2 z3), link(logmult)
ivtsri

ivtsri y (x = z1 z2 z3) if _n <= 250, link(logmult)

ivtsri y w (x = z1 z2 z3), link(logmult)

ivtsri y (x = z1 z2 z3), link(logmult) estonly
ivtsri
}

// logit link

ivtsri y (x = z1 z2 z3), link(logit)
ivtsri

ivtsri y (x = z1 z2 z3) if _n <= 100, link(logit)

ivtsri y w (x = z1 z2 z3), link(logit)

ivtsri y (x = z1 z2 z3), link(logit) estonly
ivtsri

// check errors

rcof "noi ivtsri y w (x1 x2 = z1 z2 z3)" == 198
