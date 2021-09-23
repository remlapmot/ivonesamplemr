{smcl}
{* *! version 0.1.0 Tom Palmer 03sep2021}{...}
{vieweralsosee "ivasmm" "help ivasmm"}{...}
{vieweralsosee "ivlsmm" "help ivlsmm"}{...}
{vieweralsosee "ivmsmm" "help ivmsmm"}{...}
{vieweralsosee "ivmw" "help ivmw"}{...}
{vieweralsosee "ivtsps" "help ivtsps"}{...}
{vieweralsosee "ivtsri" "help ivtsri"}{...}
{vieweralsosee "ivxtile" "help ivxtile"}{...}
{vieweralsosee "iv" "help iv"}{...}
{viewerjumpto "Commands" "ivonesamplemr##commands"}{...}
{viewerjumpto "Description" "ivonesamplemr##description"}{...}
{viewerjumpto "References" "ivonesamplemr##references"}{...}
{viewerjumpto "Author" "ivonesamplemr##author"}{...}
{title:Title}

{phang}
{bf:ivonesamplemr} {hline 2} commands for one-sample Mendelian randomization (MR) / 
instrumental variable (IV) analyses.

{phang}
{browse "https://github.com/remlapmot/ivonesamplemr#readme"}{p_end}

{title:Commands}{marker commands}

{synoptset 14 tabbed}{...}
{synopt :{opt {help ivasmm}:}}Is simply a helpfile linking to {help ivregress} and {help ivreg2}, 
which as linear IV estimators fit the additive structural mean model (ASMM), 
i.e. estimate a causal risk difference for a binary outcome.

{synopt :{opt {help ivlsmm}:}}Fits the (double) logistic structural mean model (LSMM), 
i.e. estimates a causal odds ratio for a binary outcome.

{synopt :{opt {help ivmsmm}:}}Fits the multiplicative structural mean model (MSMM), 
i.e. estimates a causal risk ratio for a binary outcome.

{synopt :{opt {help ivmw}:}}Prefix command which specifies the moving window be applied to the command 
after the prefix, e.g. {cmd:ivmw, window(100): ivmsmm ...}.

{synopt :{opt {help ivtsps}:}}Fits two-stage predictor substitution (TSPS) estimators.

{synopt :{opt {help ivtsri}:}}Fits two-stage residual inclusion (TSRI) estimators.

{synopt :{opt {help ivxtile}:}}Prefix command which performs estimation within quantiles of 
the first stage residuals.

{synopt :{opt {help iv}:}}Allows the use of the {cmd:iv} prefix, 
hence {cmd:ivlsmm} can instead be called as {cmd:iv lsmm ...}.

{marker description}{...}
{title:Description}

{pstd}
{cmd:ivonesamplemr} is a suite of programs implementing various instrumental variable (IV) estimators 
for individual level (a.k.a. one-sample) data. These are useful for Mendelian randomization (MR) analyses.

{marker references}{...}
{title:References}

{marker palmer-2011}{...}
{phang}
Palmer TM, Sterne JAC, Harbord RM, Lawlor DA, Sheehan NA, Meng S, Granell R, Davey Smith G, Didelez V. 
Instrumental variable estimation of causal risk ratios and causal odds 
ratios in Mendelian randomization analyses. 
American Journal of Epidemiology, 2011, 173, 12, 1392-1403. 
{browse "https://doi.org/10.1093/aje/kwr026":DOI}
{p_end}

{marker author}{...}
{title:Author}

INCLUDE help ivonesamplemr-author
