{smcl}
{* *! version 0.1.0  03sep2021 Tom Palmer}{...}
{vieweralsosee "onesamplemr" "help onesamplemr"}{...}
{vieweralsosee "ivregress" "help ivregress"}{...}
{vieweralsosee "ivreg2" "help ivreg2"}{...}
{viewerjumpto "Description" "asmm##description"}{...}
{viewerjumpto "Description" "asmm##examples"}{...}
{viewerjumpto "Author" "asmm##author"}{...}
{title:Title}

{p 5}
{bf:asmm} {hline 2} Additive structural mean model
{p_end}

{marker description}{...}
{title:Description}

{pstd}
{cmd:asmm} is not a command. This helpfile is to note that the additive structural mean model (ASMM) is simply fit with a linear IV estimator available in {help ivregress} or {help ivreg2} or even implemented yourself with {help gmm}.

For a binary outcome the ASMM estimates a causal risk difference.

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

{phang2}{cmd:.} {stata "ivregress 2sls y (x = z1)"}{p_end}

{pstd}Fit the model with multiple instruments.{p_end}

{phang2}{cmd:.} {stata "ivregress 2sls y (x = z1 z2 z3)"}{p_end}

{pstd}Fit the model with multiple exposures, and instruments, and adjusting for w.{p_end}

{phang2}{cmd:.} {stata "ivregress 2sls y w (x1 x2 = z1 z2 z3)"}{p_end}

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

{marker author}
{title:Author}

INCLUDE help onesamplemr-author
