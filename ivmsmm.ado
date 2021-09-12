*! 1.0.0 Tom Palmer 01sep2021
program ivmsmm, eclass

local cmdline `0'

tokenize `"`0'"', parse(",")
local cmdbeforeopts `1'

syntax [anything] [, noIRR LOG *]

if "`irr'" == "" local irr "irr"
else local irr ""

if "`log'" == "" local nolog "nolog"
else local nolog ""

ivpoisson gmm `cmdbeforeopts', multiplicative `nolog' `irr' `options'
qui ivpoisson gmm `cmdbeforeopts', multiplicative `nolog' `options' // so r(table) not exponentiated

end
exit
