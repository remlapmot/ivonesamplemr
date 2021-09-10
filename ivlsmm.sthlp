{smcl}
{* *! version 0.1.0  03sep2021 Tom Palmer}{...}
{vieweralsosee "onesamplemr" "help ivonesamplemr"}{...}
{viewerjumpto "Syntax" "ivlsmm##syntax"}{...}
{viewerjumpto "Description" "ivlsmm##description"}{...}
{viewerjumpto "Options" "ivlsmm##options"}{...}
{viewerjumpto "Examples" "ivlsmm##examples"}{...}
{viewerjumpto "Stored results" "ivlsmm##results"}{...}
{viewerjumpto "References" "ivlsmm##references"}{...}
{viewerjumpto "Author" "ivlsmm##author"}{...}
{title:Title}

{p 5}
{bf:ivlsmm} {hline 2} (double) Logistic structural mean model
{p_end}

{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmd:ivlsmm} {depvar} [{it:{help varlist:varlist1}}]
{cmd:(}{it:{help varlist:varlist2}} {cmd:=}
        {it:{help varlist:varlist_iv}}{cmd:)} {ifin}
[{it:{help gmm##weight:weight}}]
[{cmd:,} {it:options}]

{phang}
{it:varlist1} is the list of exogenous variables.{p_end}

{phang}
{it:varlist2} is the list of endogenous variables.{p_end}

{phang}
{it:varlist_iv} is the list of exogenous variables used with {it:varlist1}
   as instruments for {it:varlist2}.

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{synopt:{opt am:xb(lc:varlist)}}The linear predictor for the association model, by default the instruments and exogenous variables are included
{p_end}
{synopt:{opt from(matrix)}}initial values for the parameter estimates for both association and causal models{p_end}
{synopt:{opt l:evel(#)}}set confidence level; default is {cmd:level(95)}{p_end}
{synopt:{opt gmm_options}}Options passed to {help gmm}
{p_end}

{marker description}{...}
{title:Description}

{pstd}
{cmd:ivlsmm} implements the double logistic structural mean model (LSMM) of Vansteelandt and Goetghebeur (2003) which is a generalisation of the LSMM of Robins (1989).

{pstd}{cmd:ivlsmm} is implemented using a call to {help gmm}.

{marker options}{...}
{title:Options}

{phang}
{opt level(#)}; see {helpb estimation options##level():[R] estimation options}.

{marker examples}{...}
{title:Examples}

{pstd}Simulate binary outcome data; y outcome, x exposure, w covariate, z* instrumental variables (genotypes).{p_end}

{phang2}{cmd:.} {stata "drop _all"}{p_end}
{phang2}{cmd:.} {stata "set obs 2500"}{p_end}
{phang2}{cmd:.} {stata "set seed 12345"}{p_end}
{phang2}{cmd:.} {stata "gen z1 = rbinomial(2, .2)"}{p_end}
{phang2}{cmd:.} {stata "gen z2 = rbinomial(2, .3)"}{p_end}
{phang2}{cmd:.} {stata "gen z3 = rbinomial(2, .4)"}{p_end}
{phang2}{cmd:.} {stata "gen u = rnormal()"}{p_end}
{phang2}{cmd:.} {stata "gen w = rnormal()"}{p_end}
{phang2}{cmd:.} {stata "gen x = z1 + z2 + z3 + w + u + rnormal()"}{p_end}
{phang2}{cmd:.} {stata "gen logitpy = -2 + x + w + u"}{p_end}
{phang2}{cmd:.} {stata "gen py = invlogit(logitpy)"}{p_end}
{phang2}{cmd:.} {stata "gen y = rbinomial(1, py)"}{p_end}
{phang2}{cmd:.} {stata "gen x1 = x"}{p_end}
{phang2}{cmd:.} {stata "gen x2 = rnormal()"}{p_end}

{pstd}Fit the model with a single instrumental variable.{p_end}

{phang2}{cmd:.} {stata "ivlsmm y (x = z1)"}{p_end}

{pstd}Fit the model with multiple instruments.{p_end}

{phang2}{cmd:.} {stata "ivlsmm y (x = z1 z2 z3)"}{p_end}

{pstd}Fit the model with multiple exposures, and instruments, and adjusting for w.{p_end}

{phang2}{cmd:.} {stata "ivlsmm y w (x1 x2 = z1 z2 z3)"}{p_end}

{marker results}{...}
{title:Stored results}

{pstd}
{cmd:ivlsmm} stores the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(df_r)}}residual degrees of freedom (with {cmd:tdist} 
option){p_end}
{synopt:{cmd:e(k)}}number of instruments{p_end}
{synopt:{cmd:e(I2GX)}}I^2_GX (with {cmd:gxse()} option){p_end}
{synopt:{cmd:e(QGX)}}Q_GX (with {cmd:gxse()} option){p_end}
{synopt:{cmd:e(phi)}}Scale parameter (root mean squared error){p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:lsmm}{p_end}
{synopt:{cmd:e(cmdline)}}command as typed{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimates{p_end}

{pstd}
{cmd:ivlsmm} stores the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:r(table)}}Coefficient table with rownames: b, se, z, pvalue, ll, ul, df, crit, eform{p_end}

{marker references}{...}
{title:References}

{marker clarke}{...}
{phang}
Clarke PS, Palmer TM, Windmeijer F. Estimating structural mean models with multiple instrumental variables using the Generalised Method of Moments. Statistical Science, 2015, 30, 1, 96-117. 
{browse "https://doi.org/10.1214/14-STS503":DOI}
{p_end}

{marker robins}{...}
{phang}
Robins JM. The analysis of randomised and nonrandomised AIDS treatment trials using a new approach to causal inference in longitudinal studies. In Health Service Research Methodology: A Focus on AIDS (L. Sechrest, H. Freeman and A. Mulley, eds.). 1989. 113–159. US Public Health Service, National Center for Health Services Research, Washington, DC.
{p_end}

{marker vansteelandt}{...}
{phang}
Vansteelandt S, Goetghebeur E. 
Causal inference with generalized structural mean models. 
2003, 65, 4, 817-835. 
{browse "https://doi.org/10.1046/j.1369-7412.2003.00417.x":DOI}
{p_end}

{marker author}
{title:Author}

INCLUDE help ivonesamplemr-author
