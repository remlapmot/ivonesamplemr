{smcl}
{* *! version 0.1.0  03sep2021 Tom Palmer}{...}
{vieweralsosee "onesamplemr" "help onesamplemr"}{...}
{viewerjumpto "Syntax" "lsmm##syntax"}{...}
{viewerjumpto "Description" "lsmm##description"}{...}
{viewerjumpto "Options" "lsmm##options"}{...}
{viewerjumpto "Examples" "lsmm##examples"}{...}
{viewerjumpto "Stored results" "lsmm##results"}{...}
{viewerjumpto "References" "lsmm##references"}{...}
{viewerjumpto "Author" "lsmm##author"}{...}
{title:Title}

{p 5}
{bf:lsmm} {hline 2} (double) Logistic structural mean model
{p_end}

{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmd:lsmm} {depvar} [{it:{help varlist:varlist1}}]
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
{cmd:lsmm} implements the double logistic structural mean model (LSMM) of Vansteelandt and Goetghebeur (2003) which is a generalisation of the LSMM of Robins (1989).

{pstd}{cmd:lsmm} is implemented using a call to {help gmm}.

{marker options}{...}
{title:Options}

{phang}
{opt fe} specifies fixed effect standard errors (i.e. variance of residuals 
constrained to 1 as in fixed effect meta-analysis models). The default is 
to use multiplicative standard errors (i.e. variance of residuals 
unconstrained as in standard linear regression), see 
{help mregger##thompson:Thompson and Sharp (1999)} for further details. 
We recommend specifying this option when using an 
allelic score as the instrumental variable.

{phang}
{opt gxse(varname)} specifies the variable containing the genotype-phenotype (SNP-exposure) 
association standard errors. These are required for calculating the I^2_GX
statistic ({help mregger##i2gx:Bowden et al., 2016}). An I^2_GX statistic of 90% means that the 
likely bias due measurement error in the MR-Egger slope estimate is around 
10%. If I^2_GX values are less than 90% estimates should be treated with 
caution.
 
{phang}
{opt het:erogi} displays heterogeneity/pleiotropy 
statistics. In the heterogeneity output 
the model based Q-statistic is reported by multiplying the variance of the 
residuals by the degrees of freedom ({help mregger##delgreco:Del Greco et al., 2015}). 
For the IVW model this is the Cochran Q-statistic, and for the MR-Egger model this is the 
Ruecker's Q-statistic. The corresponding I-squared statistic and its 95% CI is also reported.
 
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

{phang2}{cmd:.} {stata "lsmm y (x = z1)"}{p_end}

{pstd}Fit the model with multiple instruments.{p_end}

{phang2}{cmd:.} {stata "lsmm y (x = z1 z2 z3)"}{p_end}

{pstd}Fit the model with multiple exposures, and instruments, and adjusting for w.{p_end}

{phang2}{cmd:.} {stata "lsmm y w (x1 x2 = z1 z2 z3)"}{p_end}

{marker results}{...}
{title:Stored results}

{pstd}
{cmd:lsmm} stores the following in {cmd:e()}:

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
{cmd:lsmm} stores the following in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:r(table)}}Coefficient table with rownames: b, se, z, pvalue, ll, ul, df, crit, eform{p_end}

{marker references}{...}
{title:References}

{marker vansteelandt}{...}
{phang}
Vansteelandt S, Goetghebeur E. 
Causal inference with generalized structural mean models. 
2003, 65, 4, 817-835. 
{browse "https://doi.org/10.1046/j.1369-7412.2003.00417.x":DOI}
{p_end}

{marker author}
{title:Author}

INCLUDE help onesamplemr-author
