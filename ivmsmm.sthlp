{smcl}
{* *! version 0.1.0  03sep2021 Tom Palmer}{...}
{vieweralsosee "ivonesamplemr" "help ivonesamplemr"}{...}
{vieweralsosee "ivpoisson" "help ivpoisson"}{...}
{vieweralsosee "ivpois" "help ivpois"}{...}
{viewerjumpto "Syntax" "ivmsmm##syntax"}{...}
{viewerjumpto "Description" "ivmsmm##description"}{...}
{viewerjumpto "Options" "ivmsmm##options"}{...}
{viewerjumpto "Examples" "ivmsmm##examples"}{...}
{viewerjumpto "Stored results" "ivmsmm##results"}{...}
{viewerjumpto "References" "ivmsmm##references"}{...}
{viewerjumpto "Author" "ivmsmm##author"}{...}
{title:Title}

{p 5}
{bf:ivmsmm} {hline 2} Multiplicative structural mean model
{p_end}

{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmd:ivmsmm} {depvar} [{it:{help varlist:varlist1}}]
{cmd:(}{it:{help varlist:varlist2}} {cmd:=}
        {it:{help varlist:varlist_iv}}{cmd:)} {ifin}
[{it:{help ivpoisson##weight:weight}}]
[{cmd:,} {opt estm:ethod(string)} {it:log} {it:noirr} {opt l:evel(#)} {it:options}]

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
{synopt:{opt estm:ethod(string)}}Estimation method: {cmd:gmmalt} (the default), {cmd:gmm}, {cmd:tsls}, or {cmd:tslsalt}{p_end}
{synopt:{opt noirr:}}Do not display exponentiated estimates{p_end}
{synopt:{opt log:}}Show the GMM iteration log{p_end}
{synopt:{opt l:evel(#)}}Set confidence level; default is {cmd:level(95)}{p_end}
{synopt:{opt options:}}Options passed to {help ivpoisson##optionstbl:ivpoisson} ({cmd:gmmalt}), {help gmm##options:gmm} ({cmd:gmm}), or {help ivregress##options:ivregress} ({cmd:tsls} and {cmd:tslsalt}){p_end}

{marker description}{...}
{title:Description}

{pstd}
{cmd:ivmsmm} implements the multiplicative structural mean model (MSMM) of {help ivmsmm##robins:Robins (1989)}, 
which estimates a causal risk ratio for a binary outcome, using the estimation methods described by 
{help ivmsmm##clarke:Clarke et al. (2015)}. These are the same methods as provided by the {cmd:msmm()} 
function in the R package {browse "https://CRAN.R-project.org/package=OneSampleMR":OneSampleMR}, 
and give the same estimates.

{pstd}
With {cmd:estmethod(gmmalt)}, the default, {cmd:ivmsmm} is a wrapper to {help ivpoisson} with the 
{cmd:multiplicative} option, which performs generalized method of moments (GMM) estimation of the 
moment conditions E[(1, Z')'{Y exp(-b0 - psi X) - 1}] = 0. 
With {cmd:estmethod(gmm)}, {cmd:ivmsmm} uses {help gmm} to fit the moment conditions 
E[(1, Z')'{Y exp(-psi X) - E[Y(0)]}] = 0, where E[Y(0)] is the mean of the exposure-free potential outcome. 
With {cmd:estmethod(tsls)} and {cmd:estmethod(tslsalt)}, which require a binary outcome and a single binary 
exposure and do not allow covariates, the MSMM is fitted by two-stage least squares, using {help ivregress}, 
of transformed variables: Y(1 - X) on YX for {cmd:tsls} and YX on Y(1 - X) for {cmd:tslsalt}. 
The causal risk ratio is then -1/b and -b respectively, where b is the coefficient of the transformed exposure, 
and its confidence interval is obtained from the delta method standard error of the log causal risk ratio.

{pstd}
The equivalence of the models of {help ivmsmm##robins:Robins (1989)} and 
{help ivmsmm##mullahy:Mullahy (1997)}, which was implemented in {help ivpois}, 
{help ivmsmm##nichols:Nichols (2007)}
and {help ivpoisson} with the {cmd:mult} option, and discussed in detail by 
{help ivmsmm##windmeijer-1:Windmeijer and Santos Silva (1997)} and 
{help ivmsmm##windmeijer-2:Windmeijer (2002)}, was shown by 
{help ivmsmm##palmer-2011:Palmer (2011)}. These models produce moment 
conditions equivalent to gamma regression 
{help ivmsmm##dukes:Dukes and Vansteelandt (2018)}. 
 
{marker options}{...}
{title:Options}

{phang}
{opt estmethod(string)} specifies the estimation method, one of {cmd:gmmalt} (the default), {cmd:gmm}, 
{cmd:tsls}, or {cmd:tslsalt}; see the Description. With {cmd:gmm} the GMM fit uses an identity initial 
weight matrix and centered moments in the optimal weight matrix ({cmd:winitial(identity) center}), as 
in the R package OneSampleMR.

{phang}
{opt noirr} specifies that the exponentiated estimates (causal risk ratios) are not displayed.

{phang}
{opt log} shows the GMM iteration log.

{phang}
{opt level(#)}; see {helpb estimation options##level():[R] estimation options}.

{phang}
Other options are passed to {help ivpoisson##options:ivpoisson}, {help gmm##options:gmm}, or 
{help ivregress##options:ivregress} depending on {cmd:estmethod()}.

{marker examples}{...}
{title:Examples}

{pstd}Read in binary outcome data; y outcome, x exposure, w covariate, z* instrumental variables (genotypes).{p_end}

{phang2}{cmd:.} {stata "use https://raw.githubusercontent.com/remlapmot/ivonesamplemr/main/data/ivbinoutdata, clear"}{p_end}

{pstd}Fit the model with a single instrumental variable.{p_end}

{phang2}{cmd:.} {stata "ivmsmm y (x = z1)"}{p_end}

{pstd}Fit the model with multiple instruments.{p_end}

{phang2}{cmd:.} {stata "ivmsmm y (x = z1 z2 z3)"}{p_end}
{phang2}{cmd:.} {stata "estat overid"}{p_end}

{pstd}Adjusting for w.{p_end}

{phang2}{cmd:.} {stata "ivmsmm y w (x = z1 z2 z3)"}{p_end}

{pstd}Fit the model with multiple exposures, and instruments, and adjusting for w.{p_end}

{phang2}{cmd:.} {stata "ivmsmm y w (x1 x2 = z1 z2 z3)"}{p_end}
{phang2}{cmd:.} {stata "estat overid"}{p_end}

{pstd}Fit the moment conditions E[(1, Z')'{Y exp(-psi X) - E[Y(0)]}] = 0.{p_end}

{phang2}{cmd:.} {stata "ivmsmm y w (x = z1 z2 z3), estmethod(gmm)"}{p_end}
{phang2}{cmd:.} {stata "estat overid"}{p_end}

{pstd}Two-stage least squares methods for a binary exposure (here a dichotomized version of x).{p_end}

{phang2}{cmd:.} {stata "gen xbin = x > 0"}{p_end}
{phang2}{cmd:.} {stata "ivmsmm y (xbin = z1 z2 z3), estmethod(tsls)"}{p_end}
{phang2}{cmd:.} {stata "ivmsmm y (xbin = z1 z2 z3), estmethod(tslsalt)"}{p_end}

{pstd}Comparison with {cmd:ivpois} (specify {cmd:onestep} option to {cmd:ivmsmm}/{cmd:ivpoisson} for equivalence).{p_end}

{phang2}{cmd:.} {stata "ivpois y, endog(x) exog(z1) eform(RR)"}{p_end}
{phang2}{cmd:.} {stata "ivpois y, endog(x) exog(z1 z2 z3) eform(RR)"}{p_end}
{phang2}{cmd:.} {stata "ivpois y w, endog(x) exog(z1 z2 z3) eform(RR)"}{p_end}
{phang2}{cmd:.} {stata "ivpois y w, endog(x1 x2) exog(z1 z2 z3) eform(RR)"}{p_end}

{marker results}{...}
{title:Stored results}

{pstd}
With {cmd:estmethod(gmmalt)} please see {help ivpoisson##results}, and with {cmd:estmethod(gmm)} 
please see {help gmm##results}. With {cmd:estmethod(tsls)} and {cmd:estmethod(tslsalt)} the results of 
{help ivregress##results:ivregress} are stored in {cmd:e()}, together with:{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(crr)}}causal risk ratio{p_end}
{synopt:{cmd:e(crr_lb)}}lower confidence limit of the causal risk ratio{p_end}
{synopt:{cmd:e(crr_ub)}}upper confidence limit of the causal risk ratio{p_end}
{synopt:{cmd:e(logcrr_se)}}delta method standard error of the log causal risk ratio{p_end}

{pstd}
In all cases {cmd:e(estmethod)} contains the estimation method.{p_end}

{marker references}{...}
{title:References}

{marker cameron}{...}
{phang}
Cameron AC, Trivedi PK. Regression analysis of count data. 2nd ed. 2013. New York, Cambridge University Press.
{browse "https://doi.org/10.1017/CBO9781139013567":DOI}
{p_end}

{marker clarke}{...}
{phang}
Clarke PS, Palmer TM, Windmeijer F. 
Estimating structural mean models with multiple instrumental variables using the Generalised Method of Moments. 
Statistical Science, 2015, 30, 1, 96-117. 
{browse "https://doi.org/10.1214/14-STS503":DOI}
{p_end}

{marker dukes}{...}
{phang}
Dukes O, Vansteelandt S. 
A note on G-estimation of causal risk ratios. 
American Journal of Epidemiology, 2018, 187, 5, 1079-1084. 
{browse "https://doi.org/10.1093/aje/kwx347":DOI}
{p_end}

{marker hernan}{...}
{phang}
Hernán and Robins. Instruments for causal inference: An Epidemiologist's dream? 
Epidemiology, 2006, 17, 360-372. 
{browse "https://doi.org/10.1097/01.ede.0000222409.00878.37":DOI}
{p_end}

{marker mullahy}{...}
{phang}
Mullahy J. Instrumental-variable estimation of count data models: 
applications to models of cigarette smoking and behavior. 
The Review of Economics and Statistics. 1997, 79, 4, 586-593. 
{browse "https://doi.org/10.1162/003465397557169":DOI}
{p_end}

{marker nichols}{...}
{phang}
Nichols A. ivpois: Stata module for IV/GMM Poisson regression. 2007. 
{browse "http://ideas.repec.org/c/boc/bocode/s456890.html":URL}
{p_end}

{marker palmer-2011}{...}
{phang}
Palmer TM, Sterne JAC, Harbord RM, Lawlor DA, Sheehan NA, Meng S, Granell R, Davey Smith G, Didelez V. 
Instrumental variable estimation of causal risk ratios and causal odds 
ratios in Mendelian randomization analyses. 
American Journal of Epidemiology, 2011, 173, 12, 1392-1403. 
{browse "https://doi.org/10.1093/aje/kwr026":DOI}
{p_end}

{marker robins}{...}
{phang}
Robins JM. 
The analysis of randomised and nonrandomised AIDS treatment trials using a new approach to 
causal inference in longitudinal studies. 
In Health Service Research Methodology: A Focus on AIDS 
(L. Sechrest, H. Freeman and A. Mulley, eds.). 
1989. 113–159. US Public Health Service, National Center for Health Services Research, Washington, DC.
{p_end}

{marker manivpoisson}{...}
{phang}
StataCorp. Stata Base Reference Manual. Release 13. 
ivpoisson - Poisson model with continuous endogenous covariates. 2013. 
{browse "https://www.stata.com/manuals13/rivpoisson.pdf":URL}
{p_end}

{marker windmeijer-1}{...}
{phang}
Windmeijer FAG, Santos Silva JMC. Endogeneity in Count Data Models: 
An Application to Demand for Health Care. 
Journal of Applied Econometrics. 1997, 12, 3, 281-294. 
{browse "https://doi.org/10.1002/(SICI)1099-1255(199705)12:3%3C281::AID-JAE436%3E3.0.CO;2-1":DOI}
{p_end}

{marker windmeijer-2}{...}
{phang}
Windmeijer, F. 
ExpEnd, A Gauss programme for non-linear GMM estimation of EXPonential models with ENDogenous regressors 
for cross section and panel data. 
CEMMAP working paper CWP14/02. 2002. 
{browse "https://www.cemmap.ac.uk/wp-content/uploads/2020/08/CWP1402.pdf":URL}
{p_end}

{marker author}{...}
{title:Author}

{pstd}
Tom Palmer, MRC Integrative Epidemiology Unit and Population Health Sciences, University of Bristol, UK. {browse "mailto:tom.palmer@bristol.ac.uk":tom.palmer@bristol.ac.uk}. 

{pstd}
Development takes place on GitHub here {browse "https://github.com/remlapmot/ivonesamplemr"}.

{pstd}
Please report any bugs or issues you find, either by email or by creating an issue on the GitHub repository here {browse "https://github.com/remlapmot/ivonesamplemr/issues"}.

{pstd}
I welcome additions to the code, either by email or pull request on GitHub.
