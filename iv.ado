*! version 0.2.0 26nov2026 Tom Palmer
program define iv
version 9

// pass everything after the subcommand through unparsed so the subcommand's
// own syntax (weights, prefix colon, etc.) applies
gettoken subcmd rest : 0, parse(" ,")

if `"`subcmd'"' == "" {
    di as err "subcommand required"
    exit 198
}
if inlist("`subcmd'", "fsw", "lsmm", "msmm", "mw", "tsps", "tsri", "xtile") {
    iv`subcmd' `rest'
}
else {
    di as err `"`subcmd' is not a valid subcommand."'
    exit 198
}

end
exit
