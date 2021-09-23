{smcl}
{* *! version 0.1.0  03sep2021 Tom Palmer}{...}
{vieweralsosee "ivonesamplemr" "help ivonesamplemr"}{...}
{vieweralsosee "ivregress" "help ivregress"}{...}
{vieweralsosee "ivreg2" "help ivreg2"}{...}
{viewerjumpto "Description" "ivasmm##description"}{...}
{viewerjumpto "Description" "ivasmm##examples"}{...}
{viewerjumpto "Author" "ivasmm##author"}{...}
{title:Title}

{p 5}
{bf:ivasmm} {hline 2} Additive structural mean model
{p_end}

{marker description}{...}
{title:Description}

{pstd}
{cmd:ivasmm} is not a command. This helpfile is to note that the additive structural mean model (ASMM) 
is simply fit with a linear IV estimator available in {help ivregress} or {help ivreg2} 
or even implemented yourself with {help gmm}.

For a binary outcome the ASMM estimates a causal risk difference.

{marker examples}{...}
{title:Examples}

{pstd}Read in binary outcome data; y outcome, x exposure, w covariate, z* instrumental variables (genotypes).{p_end}

{phang2}{cmd:.} {stata "use https://raw.github.com/remlapmot/ivonesamplemr/main/data/ivbinoutdata, clear"}{p_end}

{pstd}Fit the model with a single instrumental variable.{p_end}

{phang2}{cmd:.} {stata "ivregress 2sls y (x = z1)"}{p_end}
{phang2}{cmd:.} {stata "ivreg2 y (x = z1)"}{p_end}

{pstd}Fit the model with multiple instruments.{p_end}

{phang2}{cmd:.} {stata "ivregress 2sls y (x = z1 z2 z3)"}{p_end}
{phang2}{cmd:.} {stata "ivreg2 y (x = z1 z2 z3)"}{p_end}

{pstd}Fit the model with multiple exposures, and instruments, and adjusting for w.{p_end}

{phang2}{cmd:.} {stata "ivregress 2sls y w (x1 x2 = z1 z2 z3)"}{p_end}
{phang2}{cmd:.} {stata "ivreg2 y w (x1 x2 = z1 z2 z3)"}{p_end}

{marker references}{...}
{title:References}

{marker clarke}{...}
{phang}
Clarke PS, Palmer TM, Windmeijer F. 
Estimating structural mean models with multiple instrumental variables using the Generalised Method of Moments. 
Statistical Science, 2015, 30, 1, 96-117. 
{browse "https://doi.org/10.1214/14-STS503":DOI}
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

{marker author}{...}
{title:Author}

INCLUDE help ivonesamplemr-author
