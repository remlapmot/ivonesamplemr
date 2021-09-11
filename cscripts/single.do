// do-file for running a single cscript
// 2021-09-10

local path = subinstr("`c(pwd)'", "cscripts", "", 1)
cap noi adopath ++ "`path'"

cap noi log close _all

cscript single

// cap noi ado describe ivonesamplemr

local cscripts ivlsmm ivmsmm

foreach dofile of local cscripts {
    log using `dofile'.log, text replace name(`dofile')
    do `dofile'
    log close `dofile'
}

cap noi log close _all

cap noi adopath - "`path'"
