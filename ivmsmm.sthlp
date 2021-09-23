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
[{cmd:,} {it:log} {it:noirr} {it:ivpoisson_options}]

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
{synopt:{opt log:}}Show the GMM iteration log{p_end}
{synopt:{opt ivpoisson_options:}}{help ivpoisson##optionstbl}{p_end}

{marker description}{...}
{title:Description}

{pstd}
{cmd:ivmsmm} implements the multiplicative structural mean model (MSMM) of Robins (1989) 
as a wrapper to {help ivpoisson} with the {cmd:multiplicative} option. 
{cmd:ivpoisson} performs generalized method of moments (GMM) estimation of the relevant moment 
condition using {help gmm}.
 
{marker options}{...}
{title:Options}

{phang}
Please see {help ivpoisson##options}

{marker examples}{...}
{title:Examples}

{pstd}Read in binary outcome data; y outcome, x exposure, w covariate, z* instrumental variables (genotypes).{p_end}

{phang2}{cmd:.} {stata "use https://raw.github.com/remlapmot/ivonesamplemr/main/data/ivbinoutdata, clear"}{p_end}

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

{pstd}Comparison with {cmd:ivpois} (specify {cmd:onestep} option to {cmd:ivmsmm}/{cmd:ivpoisson} for equivalence).{p_end}

{phang2}{cmd:.} {stata "ivpois y, endog(x) exog(z1) eform(RR)"}{p_end}
{phang2}{cmd:.} {stata "ivpois y, endog(x) exog(z1 z2 z3) eform(RR)"}{p_end}
{phang2}{cmd:.} {stata "ivpois y w, endog(x) exog(z1 z2 z3) eform(RR)"}{p_end}
{phang2}{cmd:.} {stata "ivpois y w, endog(x1 x2) exog(z1 z2 z3) eform(RR)"}{p_end}

{marker results}{...}
{title:Stored results}

{pstd}
Please see {help ivpoisson##results}{p_end}

{marker references}{...}
{title:References}

{marker cameron}{...}
{phang}
Cameron AC, Trivedi PK. Regression analysis of count data. 2nd ed. 2013. New York, Cambridge University Press.
{p_end}

{marker clarke}{...}
{phang}
Clarke PS, Palmer TM, Windmeijer F. 
Estimating structural mean models with multiple instrumental variables using the Generalised Method of Moments. 
Statistical Science, 2015, 30, 1, 96-117. 
{browse "https://doi.org/10.1214/14-STS503":DOI}
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
{browse "https://t.ly/3Et7":DOI}
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

INCLUDE help ivonesamplemr-author
