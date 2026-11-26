// ivfsw cscript
// 2026-11-23

cscript ivfsw adofiles ivfsw
set varabbrev off

about

// simulate data
clear
set obs 4000
set seed 12345
gen z1 = rnormal()
gen z2 = rnormal()
gen w1 = rnormal()
gen w2 = rnormal()
gen u = rnormal()
gen x1 = z1 + z2 + 0.2*u + 0.1*w1 + rnormal()
gen x2 = z1 + 0.94*z2 - 0.3*u + 0.1*w2 + rnormal()
gen y = x1 + x2 + w1 + w2 + u

// tests

// the same as the Sanderson-Windmeijer F-statistics reported by ivreg2
ivreg2 y w1 w2 (x1 x2 = z1 z2), first
mat first = e(first)
ivfsw
mat table = r(table)
assert reldif(table[1, 1], first[rownumb(first, "SWF"), 1]) < 1e-6
assert reldif(table[2, 1], first[rownumb(first, "SWF"), 2]) < 1e-6
assert table[1, 2] == 1
assert r(K) == 2
assert r(L) == 2
assert r(N) == 4000

// the same after ivregress
ivregress 2sls y w1 w2 (x1 x2 = z1 z2)
ivfsw
assert mreldif(r(table), table) < 1e-8

// with a single exposure this is the usual first stage F-statistic
ivregress 2sls y w1 w2 (x1 = z1 z2)
ivfsw
mat table1 = r(table)
regress x1 z1 z2 w1 w2
test z1 z2
assert reldif(table1[1, 1], r(F)) < 1e-8

// the estimation results are left unchanged
ivregress 2sls y w1 w2 (x1 x2 = z1 z2)
mat b = e(b)
ivfsw
assert "`e(cmd)'" == "ivregress"
assert mreldif(e(b), b) == 0

// weights and robust and cluster-robust variances: the same as ivreg2 after
// both ivreg2 and ivregress
gen z3 = rnormal()
gen wt = 1 + (runiform() > .5) * 3
gen cl = ceil(_n / 40)
replace x1 = x1 + rnormal() * abs(z1)
local specs `"", first" ", robust first" ", cluster(cl) first" " [aw=wt], first" " [fw=wt], first" " [pw=wt], first" " [aw=wt], cluster(cl) first""'
foreach spec of local specs {
    di _n as txt "ivreg2`spec'"
    ivreg2 y w1 w2 (x1 x2 = z1 z2 z3) `spec'
    mat first = e(first)
    ivfsw
    mat table = r(table)
    assert reldif(table[1, 1], first[rownumb(first, "SWF"), 1]) < 1e-6
    assert reldif(table[2, 1], first[rownumb(first, "SWF"), 2]) < 1e-6
    assert table[1, 3] == first[rownumb(first, "SWFdf2"), 1]
    local ivregspec = subinstr("`spec'", " first", "", 1)
    local ivregspec = subinstr("`ivregspec'", "robust", "vce(robust)", 1)
    local ivregspec = subinstr("`ivregspec'", "cluster(cl)", "vce(cluster cl)", 1)
    ivregress 2sls y w1 w2 (x1 x2 = z1 z2 z3) `ivregspec'
    ivfsw
    assert mreldif(r(table), table) < 1e-6
}

// unsupported variance types
gen cl2 = mod(_n, 37)
ivreg2 y w1 w2 (x1 x2 = z1 z2 z3), cluster(cl cl2)
rcof "ivfsw" == 498
gen t = _n
tsset t
ivregress 2sls y w1 w2 (x1 x2 = z1 z2 z3), vce(hac nwest 2)
rcof "ivfsw" == 498
tsset, clear

// error after another estimation command
regress y x1
rcof "ivfsw" == 301
