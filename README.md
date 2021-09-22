# ivonesamplemr Stata package

Stata package of useful programs for one-sample Mendelian randomization (MR) / instrumental variable (IV) analyses, including implementations of:

* additive structural mean model: See `help ivasmm`
* logistic structural mean model: `ivlsmm` command
* multiplicative structural mean model: `ivmsmm` command
* two-stage predictor substitution estimators: `ivtsps` command
* two-stage residual inclusion estimators: `ivtsri` command
* moving window versions of these estimators: `ivmw` prefix command
* performing estimation within quantiles of the first stage residuals: `ivxtile` prefix command

The `ivtsps` and `ivtsri` commands implement the following link functions for the second stage model: 

* identity (i.e. linear regression) - for a binary outcome this estimates a causal risk difference 
* logadd (log additive, i.e. Poisson regression) and logmult (log multiplicative, i.e. gamma regression) - for a binary outcome these estimate a causal risk ratio
* logit (i.e. logistic regression) - for a binary outcome this estimates a causal odds ratio

## Installation

Install the ivonesamplemr package within Stata using
``` stata
net install github, from("https://haghish.github.io/github/")
github install remlapmot/ivonesamplemr
```

Or use the following code
``` stata
net install ivonesamplemr, from("https://raw.github.com/remlapmot/ivonesamplemr/main/") replace
do "https://raw.github.com/remlapmot/ivonesamplemr/main/dependency.do"
```

Launch the main package helpfile with
``` stata
help ivonesamplemr
```

To check for an update to the package run within Stata
``` stata
adoupdate ivonesamplemr, update
```

Uninstall the package within Stata using
``` stata
ado uninstall ivonesamplemr
```
