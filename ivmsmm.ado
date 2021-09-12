*! 1.0.0 Tom Palmer 01sep2021
program ivmsmm, eclass

local cmdline `0'

syntax [anything] [if] [in] [aw fw iw pw] [, noIRR LOG *]

local comma ""
if "`options'" == "" & "`irr'" == "" & "`log'" == "" local comma ","

if "`log'" == "" local nolog "nolog"
else local nolog ""

if "`irr'" == "" local irr "irr"
else local irr ""

ivpoisson gmm `cmdline' `comma' multiplicative `nolog' `irr'
qui ivpoisson gmm `cmdline' `comma' multiplicative `nolog' `irr' // so r(table) not exponentiated

end
exit
