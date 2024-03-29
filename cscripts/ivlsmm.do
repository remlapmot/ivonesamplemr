// ivlsmm cscript
// 2021-08-27

cscript ivlsmm adofiles ivlsmm

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

discard
ivlsmm y w (x = z1)
assert abs(_b[/cmxb_x] - 1) < 1e-2

// estimates replay
ivlsmm

// ereturn list
eret list

// r(table)
mat list r(table)

// multiple instruments
discard
ivlsmm y w (x = z1 z2 z3)
assert abs(_b[/cmxb_x] - .89) < 1e-2

// multiple endog variables
discard
ivlsmm y w (x1 x2 = z1 z2 z3)
assert abs(_b[/cmxb_x1] - .86) < 1e-2
assert abs(_b[/cmxb_x2] - -.82) < 1e-2

mat start = J(1,9,1)
mat list start
discard
ivlsmm y w (x = z1 z2 z3), from(start)
assert abs(_b[/cmxb_x] - .89) < 1e-2

// check if in working
discard
ivlsmm y (x = z1 z2 z3) if _n <= 100
assert abs(_b[/cmxb_x] - 1.21) < 1e-2

discard
ivlsmm y (x = z1 z2 z3) in 1/100
assert abs(_b[/cmxb_x] - 1.21) < 1e-2

// check `options'
discard
ivlsmm y (x = z1 z2 z3) if _n <= 100
assert abs(_b[/cmxb_x] - 1.21) < 1e-2

// amxb test
discard
ivlsmm y w (x = z1 z2 z3), amxb(x z1 z2 z3)
assert abs(_b[/cmxb_x] - .85) < 1e-2

discard
gen xz1 = x*z1
gen xz2 = x*z2
gen xz3 = x*z3
ivlsmm y w (x = z1 z2 z3), amxb(x w z1 z2 z3 xz1 xz2 xz3)
assert abs(_b[/cmxb_x] - .90) < 1e-2

// overid test
ivlsmm y (x = z1 z2 z3)
assert abs(e(J) - 1.882) < 1e-3
assert e(J_df) == 2
assert abs(e(J_p) - .39) < 1e-2
