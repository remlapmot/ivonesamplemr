# ivonesamplemr Stata package

Stata package of useful programs for one-sample Mendelian randomization (MR) / instrumental variable (IV) analyses, including implementations of:

* additive structural mean model: See `help ivasmm`
* logistic structural mean model: `ivlsmm` command
* multiplicative structural mean model: `ivmsmm` command
* two-stage predictor substitution estimators: `ivtsps` command
* two-stage residual inclusion estimators: `ivtsri` command

The `ivtsps` and `ivtsri` commands implement the following link functions: 

* identity - for a binary outcome this estimates a causal risk difference 
* log (additive and multiplicative) - for a binary outcome this estimates a causal risk ratio
* logit - for a binary outcome this estimates a causal odds ratio

## Installation

Install the onesamplemr package within Stata using
``` stata
net install github, from("https://haghish.github.io/github/")
github install remlapmot/ivonesamplemr
```

Or use the following code
``` stata
net install ivonesamplemr, from("https://raw.github.com/remlapmot/ivonesamplemr/main/") replace
do "https://raw.github.com/remlapmot/ivonesamplemr/main/dependency.do"
```

To check for an update to the package run within Stata
``` stata
adoupdate ivonesamplemr, update
```

Uninstall the package within Stata using
``` stata
ado uninstall ivonesamplemr
```

And then launch the main package helpfile with
``` stata
help ivonesamplemr
```
