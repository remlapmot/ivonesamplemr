dep:
    stata-mp "do dependency"
render:
    quarto render site
    rm -r docs/*
    mv site/_site/* docs/

[working-directory('cscripts')]
test: uninstall
    stata-mp -b "do master"

[working-directory('site')]
dev:
    stata-mp "do developer"

uninstall:
    #!/usr/bin/env bash
    # ivonesamplemr may be installed multiple times. `ado uninstall ivonesamplemr` fails with
    # r(111) ("matches more than one package") when there are duplicates, and each
    # uninstall renumbers the remaining packages, so we re-query `ado dir ivonesamplemr`
    # and remove one [#] at a time until none remain. The iteration cap is just a
    # safety stop against an unexpected non-terminating loop.
    for _ in $(seq 1 100); do
        n=$(printf 'ado dir ivonesamplemr\n' | stata-mp -q | grep -oE '\[[0-9]+\]' | head -1)
        [ -z "$n" ] && break
        printf 'ado uninstall %s\n' "$n" | stata-mp -q
    done
    echo "Remaining ivonesamplemr packages (should be none):"
    printf 'ado dir ivonesamplemr\n' | stata-mp -q

install: uninstall
    printf 'net install ivonesamplemr, from("https://raw.githubusercontent.com/remlapmot/ivonesamplemr/main/") replace\nado dir ivonesamplemr\n' | stata-mp -q
