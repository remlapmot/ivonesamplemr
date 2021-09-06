{smcl}
{* *! version 0.1.0 Tom Palmer 03sep2021}{...}
{vieweralsosee "asmm" "help asmm"}{...}
{vieweralsosee "lsmm" "help lsmm"}{...}
{vieweralsosee "msmm" "help msmm"}{...}
{vieweralsosee "tsps" "help tsps"}{...}
{vieweralsosee "tsri" "help tsri"}{...}
{viewerjumpto "Commands" "onesamplemr##commands"}{...}
{viewerjumpto "Description" "onesamplemr##description"}{...}
{viewerjumpto "Author" "onesamplemr##author"}{...}
{title:Title}

{phang}
{bf:onesamplemr} {hline 2} commands for one-sample Mendelian randomization / instrumental variable analyses.

{phang}
{browse "https://github.com/remlapmot/onesamplemr-stata#readme"}{p_end}

{title:Commands}{marker commands}

{synoptset 14 tabbed}{...}
{synopt :{opt {help asmm}:}}Is a helpfile that links to {help ivregress} and {help ivreg2} which as linear IV estimators fit the additive structural mean model (ASMM), i.e. estimates a causal risk difference for a binary outcome.

{synopt :{opt {help lsmm}:}}Fits the (double) logistic structural mean model (LSMM), i.e. estimates a causal odds ratio for a binary outcome.

{synopt :{opt {help msmm}:}}Fits the multiplicative structural mean model (MSMM), i.e. estimates a causal risk ratio for a binary outcome.

{synopt :{opt {help tsps}:}}Fits two-stage predictor substitution (TSPS) estimators.

{synopt :{opt {help tsri}:}}Fits two-stage residual inclusion (TSRI) estimators.

{marker description}{...}
{title:Description}

{pstd}
{cmd:onesamplemr} is a suite of programs implementing various instrumental variable estimators for individual level data. 

{title:Author}{marker author}

INCLUDE help onesamplemr-author
