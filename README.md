# onesamplemr Stata package

Stata package of useful programs for one sample Mendelian randomization / instrumental variable 
analyses, including implementations of:

* logistic structural mean model (`lsmm` command)

## Installation

Install the onesamplemr package within Stata using
``` stata
net install onesamplemr, from("https://raw.github.com/remlapmot/onesample-mr/master/") replace
```

To check for an update to the package run within Stata
``` stata
adoupdate onesamplemr, update
```

Uninstall the package within Stata using
``` stata
ado uninstall onesamplemr
```
