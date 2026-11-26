// ivlsmm cscript
// 2021-08-27

cscript iv adofiles iv
set varabbrev off

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

// weights are passed through to the subcommand
gen wt = 1 + (z1 > 0)
iv msmm y (x = z1 z2 z3) [fw=wt]
matrix b_iv = e(b)
ivmsmm y (x = z1 z2 z3) [fw=wt]
assert mreldif(b_iv, e(b)) < 1e-12

iv msmm y (x = z1 z2 z3) [pw=wt]

// postestimation and prefix subcommands
ivreg2 y w (x1 x2 = z1 z2 z3)
iv fsw

ivregress 2sls y w (x1 x2 = z1 z2 z3)
iv fsw

iv mw, window(2400) par(x): ivregress 2sls y (x = z1 z2 z3)

iv xtile, nq(4) par(x): ivreg2 y (x = z1 z2 z3)

// invalid and missing subcommands
rcof "iv foo y (x = z1)" == 198
rcof "iv" == 198
