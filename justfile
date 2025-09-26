dep:
    stata-mp "do dependency"

[working-directory: 'cscripts']
test:
    stata-mp -b "do master"

[working-directory: 'site']
dev:
    stata-mp "do developer"
