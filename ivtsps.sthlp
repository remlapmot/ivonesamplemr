{smcl}
{* *! version 0.1.0  03sep2021 Tom Palmer}{...}
{vieweralsosee "ivonesamplemr" "help ivonesamplemr"}{...}
{viewerjumpto "Syntax" "ivtsps##syntax"}{...}
{viewerjumpto "Description" "ivtsps##description"}{...}
{viewerjumpto "Options" "ivtsps##options"}{...}
{viewerjumpto "Examples" "ivtsps##examples"}{...}
{viewerjumpto "Stored results" "ivtsps##results"}{...}
{viewerjumpto "References" "ivtsps##references"}{...}
{viewerjumpto "Author" "ivtsps##author"}{...}
{title:Title}

{p 5}
{bf:ivtsps} {hline 2} Two-stage predictor substitution estimators
{p_end}

{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmd:ivtsps} {depvar} [{it:{help varlist:varlist1}}]
{cmd:(}{it:{help varlist:varlist2}} {cmd:=}
        {it:{help varlist:varlist_iv}}{cmd:)} {ifin}
[{it:{help gmm##weight:weight}}]
[{cmd:,} {it:link(string)} {it:log} {it:noirr} {it:gmm_options}]

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
{synopt:{opt noirr:}}Do not display exponentiated estimates{p_end}
{synopt:{opt link:(string)}}Link function for the second stage model (identity | logadd | logmult | logit){p_end}
{synopt:{opt log:}}Show the GMM iteration log{p_end}
{synopt:{opt gmm_options:}}{help gmm##options}{p_end}

{marker description}{...}
{title:Description}

{pstd}
{cmd:ivtsps} implements two-stage predictor substitution (TSPS) estimators with several link functions for the second stage model 
(identity, log-additive, log-multiplicative, logit). 
It is implemented using generalized method of moments (GMM) estimation by passing the relevant 
moment condition to the {help gmm} command.
 
{marker options}{...}
{title:Options}

{phang}
{opt link(identity | logadd | logmult | logit)} specifies the link function for the second stage model. 
{cmd:identity} means the second stage model is a linear regression 
(which for a binary outcome estimates a causal risk difference). 
{cmd:logadd} means the second stage model is a Poisson/log-binomial regression 
(which for a binary outcome estimates a causal risk ratio).
{cmd:logmult} means the second stage model is a gamma regression 
(which for a binary outcome estimates a causal risk ratio, 
{help ivtsri##dukes:Dukes and Vansteelandt, 2018}). 
{cmd:logit} means the second stage model is a logistic regression 
(which for a binary outcome estimates a causal odds ratio). 

{phang}
Please see {help gmm##options}

{marker examples}{...}
{title:Examples}

{pstd}Read in binary outcome data; y outcome, x exposure, w covariate, z* instrumental variables (genotypes).{p_end}

{phang2}{cmd:.} {stata "use https://raw.github.com/remlapmot/ivonesamplemr/main/data/ivbinoutdata, clear"}{p_end}

{pstd}Fit the model with a single instrumental variable.{p_end}

{phang2}{cmd:.} {stata "ivtsps y (x = z1)"}{p_end}

{pstd}Fit the model with multiple instruments.{p_end}

{phang2}{cmd:.} {stata "ivtsps y (x = z1 z2 z3)"}{p_end}

{pstd}Fit the model with multiple instruments, and adjusting for w.{p_end}

{phang2}{cmd:.} {stata "ivtsps y w (x = z1 z2 z3)"}{p_end}

{pstd}Using the log additive link function.{p_end}

{phang2}{cmd:.} {stata "ivtsps y (x = z1 z2 z3), link(logadd)"}{p_end}

{pstd}Using the log multiplicative link function.{p_end}

{phang2}{cmd:.} {stata "ivtsps y (x = z1 z2 z3), link(logmult)"}{p_end}

{pstd}Using the logit link function.{p_end}

{phang2}{cmd:.} {stata "ivtsps y (x = z1 z2 z3), link(logit)"}{p_end}

{pstd}Bootstrap standard errors.{p_end}
{phang2}{cmd:.} {stata "bootstrap, reps(250): ivtsps y (x = z1 z2 z3), estonly"}{p_end}

{marker results}{...}
{title:Stored results}

{pstd}
Please see {help gmm##results}{p_end}

{marker references}{...}
{title:References}

{marker dukes}{...}
{phang}
Dukes O, Vansteelandt S. 
A note on G-estimation of causal risk ratios. 
American Journal of Epidemiology, 2018, 187, 5, 1079-1084. 
{browse "https://doi.org/10.1093/aje/kwx347":DOI}
{p_end}

{marker palmer-2011}{...}
{phang}
Palmer TM, Sterne JAC, Harbord RM, Lawlor DA, Sheehan NA, Meng S, Granell R, Davey Smith G, Didelez V. 
Instrumental variable estimation of causal risk ratios and causal odds 
ratios in Mendelian randomization analyses. 
American Journal of Epidemiology, 2011, 173, 12, 1392-1403. 
{browse "https://doi.org/10.1093/aje/kwr026":DOI}
{p_end}

{marker terza}{...}
{phang}
Terza JV, Basu A, Rathouz PJ. 2008. 
Two-stage residual inclusion estimation: 
Addressing endogeneity in health econometric modeling. 
Journal of Health Economics 27: 531–543.
{browse "https://doi.org/10.1016/j.jhealeco.2007.09.009":DOI}
{p_end}

{marker author}{...}
{title:Author}

INCLUDE help ivonesamplemr-author
