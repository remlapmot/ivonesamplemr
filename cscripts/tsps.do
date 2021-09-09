// tsps cscript
// 2021-09-06

cscript tsps adofiles tsps

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

tsps y (x = z1 z2 z3)
tsps

tsps y (x = z1 z2 z3) if _n <= 50

tsps y (x = z1 z2 z3), link(identity)

tsps y w (x = z1 z2 z3), link(identity)

tsps y (x = z1 z2 z3), estonly
tsps

// logadd link

cap noi {
tsps y (x = z1 z2 z3), link(logadd)
tsps

tsps y (x = z1 z2 z3) if _n <= 200, link(logadd)

tsps y w (x = z1 z2 z3), link(logadd)

tsps y (x = z1 z2 z3), link(logadd) estonly
tsps
}

// logmult link

cap noi {
tsps y (x = z1 z2 z3), link(logmult)
tsps

tsps y (x = z1 z2 z3) if _n <= 250, link(logmult)

tsps y w (x = z1 z2 z3), link(logmult)

tsps y (x = z1 z2 z3), link(logmult) estonly
tsps
}

// logit link

tsps y (x = z1 z2 z3), link(logit)
tsps

tsps y (x = z1 z2 z3) if _n <= 100, link(logit)

tsps y w (x = z1 z2 z3), link(logit)

tsps y (x = z1 z2 z3), link(logit) estonly
tsps

// check errors

rcof "noi tsps y w (x1 x2 = z1 z2 z3)" == 198
