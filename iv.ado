*! version 0.1.0 10sep2021 Tom Palmer
program define iv
version 9
syntax anything(everything) [aweight] [if] [in] [, *]

local subcmd "`1'"
local rest = subinword("`0'", "`subcmd'", "", 1)

if "`subcmd'" == "lsmm" {
    ivlsmm `rest'
}
else if "`subcmd'" == "msmm" {
    ivmsmm `rest'
}
else if "`subcmd'" == "tsps" {
    ivtsps `rest'
}
else if "`subcmd'" == "tsri" {
    ivtsri `rest'
}
else {
    di as err "`subcmd' is not a valid subcommand."
    exit 198
}

end
exit
