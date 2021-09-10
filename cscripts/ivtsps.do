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

ivtsps y (x = z1 z2 z3)
ivtsps

ivtsps y (x = z1 z2 z3) if _n <= 50

ivtsps y (x = z1 z2 z3), link(identity)

ivtsps y w (x = z1 z2 z3), link(identity)

ivtsps y (x = z1 z2 z3), estonly
ivtsps

// logadd link

cap noi {
ivtsps y (x = z1 z2 z3), link(logadd)
ivtsps

ivtsps y (x = z1 z2 z3) if _n <= 200, link(logadd)

ivtsps y w (x = z1 z2 z3), link(logadd)

ivtsps y (x = z1 z2 z3), link(logadd) estonly
ivtsps
}

// logmult link

cap noi {
ivtsps y (x = z1 z2 z3), link(logmult)
ivtsps

ivtsps y (x = z1 z2 z3) if _n <= 250, link(logmult)

ivtsps y w (x = z1 z2 z3), link(logmult)

ivtsps y (x = z1 z2 z3), link(logmult) estonly
ivtsps
}

// logit link

ivtsps y (x = z1 z2 z3), link(logit)
ivtsps

ivtsps y (x = z1 z2 z3) if _n <= 100, link(logit)

ivtsps y w (x = z1 z2 z3), link(logit)

ivtsps y (x = z1 z2 z3), link(logit) estonly
ivtsps

// check errors

rcof "noi ivtsps y w (x1 x2 = z1 z2 z3)" == 198
