// tsri cscript
// 2021-09-06

cscript tsri adofiles tsri

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

tsri y (x = z1 z2 z3)
tsri

tsri y (x = z1 z2 z3) if _n <= 50

tsri y (x = z1 z2 z3), link(identity)

tsri y w (x = z1 z2 z3), link(identity)

tsri y (x = z1 z2 z3), estonly
tsri

// logadd link

cap noi {
tsri y (x = z1 z2 z3), link(logadd)
tsri

tsri y (x = z1 z2 z3) if _n <= 200, link(logadd)

tsri y w (x = z1 z2 z3), link(logadd)

tsri y (x = z1 z2 z3), link(logadd) estonly
tsri
}

// logmult link

cap noi {
tsri y (x = z1 z2 z3), link(logmult)
tsri

tsri y (x = z1 z2 z3) if _n <= 250, link(logmult)

tsri y w (x = z1 z2 z3), link(logmult)

tsri y (x = z1 z2 z3), link(logmult) estonly
tsri
}

// logit link

tsri y (x = z1 z2 z3), link(logit)
tsri

tsri y (x = z1 z2 z3) if _n <= 100, link(logit)

tsri y w (x = z1 z2 z3), link(logit)

tsri y (x = z1 z2 z3), link(logit) estonly
tsri

// check errors

rcof "noi tsri y w (x1 x2 = z1 z2 z3)" == 198
