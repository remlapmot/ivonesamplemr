// data for ivmw helpfile
// 2021-09-13

drop _all
set obs 4000
set seed 12345
gen g = rbinomial(2, .3)
gen u = runiform()
gen ex = rexponential(1)
gen x = .25*g + u + ex
gen ey = rnormal()
gen y1 = .4*x + .8*u + ey
gen y2 = .1*x^2
gen y3 = .2*(x - 1)^2
gen y4 = .3*(x - 2)^2
gen y5 = max(x - 2, 0)

saveold ivmwdata, version(12) replace
