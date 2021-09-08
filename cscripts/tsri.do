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

discard
tsri y (x = z1 z2 z3)

tsri y (x = z1 z2 z3), link(identity)

tsri y (x = z1 z2 z3), link(logadd)

tsri y (x = z1 z2 z3), link(logmult)

discard
tsri y (x = z1 z2 z3), link(logit)

tsri y w (x = z1 z2 z3)

cap noi tsri y w (x1 x2 = z1 z2 z3)
