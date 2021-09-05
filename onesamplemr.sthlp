{smcl}
{* *! version 0.1.0 Tom Palmer 03sep2021}{...}
{vieweralsosee "asmm" "help asmm"}{...}
{vieweralsosee "lsmm" "help lsmm"}{...}
{vieweralsosee "msmm" "help msmm"}{...}
{viewerjumpto "Commands" "onesamplemr##commands"}{...}
{viewerjumpto "Description" "onesamplemr##description"}{...}
{viewerjumpto "Author" "onesamplemr##author"}{...}
{title:Title}

{phang}
{bf:onesamplemr} {hline 2} commands for one-sample Mendelian randomization / instrumental variable analyses.

{phang}
{browse "https://remlapmot.github.io/onesamplemr-stata/"}{p_end}

{title:Commands}{marker commands}

{synoptset 14 tabbed}{...}
{synopt :{opt {help asmm}:}}Is a helpfile that links to {help ivregress} and {help ivreg2} which as linear IV estimators fits the additive structural mean model, i.e. estimates a causal risk difference for a binary outcome.

{synopt :{opt {help lsmm}:}}Fits the (double) logistic structural mean model, i.e. estimates a causal odds ratio for a binary outcome.

{synopt :{opt {help msmm}:}}Fits the multiplicative structural mean model, i.e. estimates a causal risk ratio for a binary outcome.

{marker description}{...}
{title:Description}

{pstd}
{cmd:onesamplemr} is a suite of programs implementing various instrumental variable estimators for individual level data. 

{pstd}
There is a website showing the examples from the helpfiles here: {browse "https://remlapmot.github.io/onesamplemr-stata/"}{p_end}

{title:Author}{marker author}

INCLUDE help onesamplemr-author
