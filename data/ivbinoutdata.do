// binary outcome IV dataset
// 2021-09-13

clear all
set obs 2500
set seed 12345
gen z1 = rbinomial(2, .2)
gen z2 = rbinomial(2, .3)
gen z3 = rbinomial(2, .4)
gen u = rnormal()
gen w = rnormal()
gen x1 = z1 + z2 + z3 + w + u + rnormal()
gen x = x1
gen x2 = z1 + z2 + u + rnormal()
gen logitpy = -2 + x1 + 0.5*x2 + w + u
gen py = invlogit(logitpy)
gen y = rbinomial(1, py)
tab y
ds

saveold ivbinoutdata, replace version(12)
