// ivlsmm cscript
// 2021-08-27

cscript iv adofiles iv

about

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

iv lsmm y (x = z1)

iv msmm y (x = z1 z2 z3)

iv tsps y (x = z1 z2 z3)

iv tsri y (x = z1 z2 z3), link(logit)
