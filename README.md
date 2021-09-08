# onesamplemr Stata package

Stata package of useful programs for one sample Mendelian randomization / instrumental variable 
analyses, including implementations of:

* additive structural mean model: See `help asmm`
* logistic structural mean model: `lsmm` command
* multiplicative structural mean model: `msmm` command
* two-stage predictor substitution estimators: `tsps` command
* two-stage residual inclusion estimators: `tsri` command

## Installation

Install the onesamplemr package within Stata using
``` stata
net install github, from("https://haghish.github.io/github/")
github install remlapmot/onesamplemr-stata, package(onesamplemr)
```

Or use the following code
```
net install onesamplemr, from("https://raw.github.com/remlapmot/onesample-mr/main/") replace
do https://raw.github.com/remlapmot/onesample-mr/main/dependency.do
```

To check for an update to the package run within Stata
``` stata
adoupdate onesamplemr, update
```

Uninstall the package within Stata using
``` stata
ado uninstall onesamplemr
```

And then launch the package helpfile with
``` stata
help onesamplemr
```
