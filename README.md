# ivonesamplemr Stata package

Stata package of useful programs for one-sample Mendelian randomization (MR) / instrumental variable (IV) analyses, including implementations of:

* additive structural mean model: see `help ivasmm`
* logistic structural mean model: see `help ivlsmm`
* multiplicative structural mean model: see `help ivmsmm`
* two-stage predictor substitution estimators: see `ivtsps`
* two-stage residual inclusion estimators: see `help ivtsri`
* moving window (a.k.a. sliding/rolling window) versions of these estimators: see `help ivmw`
* performing estimation within quantiles of the first stage residuals: see `help ivxtile`

The `ivtsps` and `ivtsri` commands implement the following link functions for the second stage model: 

* identity (i.e. linear regression) - for a binary outcome this estimates a causal risk difference 
* logadd (log additive, i.e. Poisson/log-binomial regression) and logmult (log multiplicative, i.e. gamma regression) - for a binary outcome these estimate a causal risk ratio
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
