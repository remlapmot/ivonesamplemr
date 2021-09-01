// lsmm cscript
// 2021-08-27

cscript lsmm adofiles lsmm

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

lsmm y w (x = z1 z2 z3)

gen x1 = x
gen x2 = rnormal()
lsmm y w (x1 x2 = z1 z2 z3)

mat start = J(1,9,1)
mat list start
lsmm y w (x = z1 z2 z3), from(start)

// check if in working
lsmm y (x = z1 z2 z3) if _n <= 100
lsmm y (x = z1 z2 z3) in 1/100

lsmm y (x = z1 z2 z3) if _n <= 100, nolog


// amxb test