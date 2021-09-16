{smcl}
{* *! version 0.1.0  16sep2021 Tom Palmer}{...}
{vieweralsosee "ivonesamplemr" "help ivonesamplemr"}{...}
{vieweralsosee "xtile" "help xtile"}{...}
{viewerjumpto "Syntax" "ivxtile##syntax"}{...}
{viewerjumpto "Description" "ivxtile##description"}{...}
{viewerjumpto "Options" "ivxtile##options"}{...}
{viewerjumpto "Examples" "ivxtile##examples"}{...}
{viewerjumpto "Stored results" "ivxtile##results"}{...}
{viewerjumpto "References" "ivxtile##references"}{...}
{viewerjumpto "Author" "ivxtile##author"}{...}
{title:Title}

{p 5}
{bf:ivmw} {hline 2} Perorm estimation within quantiles of the first stage residuals prefix command
{p_end}

{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{cmd:ivxtile} {cmd:,} {opt window(#)} {opt par(string)} [{opt sa:ving(string)} {opt rolling_options}]{cmd::} {it:iv_cmd}

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{synopt:{opt par:(string)}}Parameter from the {it:iv_cmd} (ivreg2, ivmsmm, ivlsmm, ivtsps, ivtsri) to collect{p_end}
{synopt:{opt window:(#)}}number of consecutive data points in each sample{p_end}
{synopt:{opt sa:ving(string)}}Save the moving window output to a dataset. 
Specify {cmd:, replace} to overwrite an existing dataset{p_end}
{synopt:{opt rolling_options:}}{help rolling##options}{p_end}

{marker description}{...}
{title:Description}

{pstd}
{cmd:ivxtile} implements the moving window (a.k.a. sliding / rolling window) approach to the estimator 
specified after the prefix, as per {help ivmw##burgess:Burgess et al., 2014}. 
It is implemented as a call to {help xtile}.
 
{marker options}{...}
{title:Options}

{phang}
Please see {help xtile##options}

{marker examples}{...}
{title:Examples}

{pstd}Simulate data with different outcome-exposure relationships; y# outcome, x exposure, g instrumental variable (genotype).{p_end}

{phang2}{cmd:.} {stata "use https://raw.github.com/remlapmot/ivonesamplemr/main/data/ivmwdata, clear"}{p_end}

{pstd}Plot outcome-exposure relationships{p_end}

{phang2}{cmd:.} {stata "twoway line y1 x, sort(x)"}{p_end}
{phang2}{cmd:.} {stata "twoway line y2 y3 y4 x, sort(x)"}{p_end}
{phang2}{cmd:.} {stata "twoway line y5 x, sort(x)"}{p_end}

{pstd}Example moving window fits.{p_end}

{phang2}{cmd:.} {stata "ivmw, window(3950) par(x): ivreg2 y1 (x = g)"}{p_end}
{phang2}{cmd:.} {stata "ivmw, window(3950) par(x): ivreg2 y2 (x = g)"}{p_end}
{phang2}{cmd:.} {stata "ivmw, window(3950) par(x): ivreg2 y3 (x = g)"}{p_end}
{phang2}{cmd:.} {stata "ivmw, window(3950) par(x): ivreg2 y4 (x = g)"}{p_end}
{phang2}{cmd:.} {stata "ivmw, window(3950) par(x): ivreg2 y5 (x = g)"}{p_end}

{pstd}Change window size (e.g. for outcome y2).{p_end}

{phang2}{cmd:.} {stata "ivmw, window(3750) par(x): ivreg2 y2 (x = g)"}{p_end}
{phang2}{cmd:.} {stata "ivmw, window(3000) par(x): ivreg2 y2 (x = g)"}{p_end}
{phang2}{cmd:.} {stata "ivmw, window(2000) par(x): ivreg2 y2 (x = g)"}{p_end}
{phang2}{cmd:.} {stata "ivmw, window(1000) par(x): ivreg2 y2 (x = g)"}{p_end}

{pstd}Save the moving window dataset.{p_end}

{phang2}{cmd:.} {stata "ivmw, window(3950) par(x) saving(ivmw): ivreg2 y2 (x = g)"}{p_end}

{pstd}Use different iv commands.{p_end}

{phang2}{cmd:.} {stata "ivmw, window(3950) par(x): ivregress 2sls y (x = z1 z2 z3)"}{p_end}
{phang2}{cmd:.} {stata "ivmw, window(3950) par(x): ivregress liml y (x = z1 z2 z3)"}{p_end}
{phang2}{cmd:.} {stata "ivmw, window(3950) par(x): ivregress gmm y (x = z1 z2 z3)"}{p_end}
{phang2}{cmd:.} {stata "ivmw, window(3950) par(x): ivlsmm y (x = z1 z2 z3)"}{p_end}
{phang2}{cmd:.} {stata "ivmw, window(3950) par(x): ivmsmm y (x = z1 z2 z3)"}{p_end}
{phang2}{cmd:.} {stata "ivmw, window(3950) par(b1): ivtsps y (x = z1 z2 z3)"}{p_end}
{phang2}{cmd:.} {stata "ivmw, window(3950) par(b1): ivtsps y (x = z1 z2 z3), link(logadd)"}{p_end}
{phang2}{cmd:.} {stata "ivmw, window(3950) par(b1): ivtsps y (x = z1 z2 z3), link(logmult)"}{p_end}
{phang2}{cmd:.} {stata "ivmw, window(3950) par(b1): ivtsps y (x = z1 z2 z3), link(logit)"}{p_end}
{phang2}{cmd:.} {stata "ivmw, window(3950) par(b1): ivtsri y (x = z1 z2 z3)"}{p_end}
{phang2}{cmd:.} {stata "ivmw, window(3950) par(b1): ivtsri y (x = z1 z2 z3), link(logadd)"}{p_end}
{phang2}{cmd:.} {stata "ivmw, window(3950) par(b1): ivtsri y (x = z1 z2 z3), link(logmult)"}{p_end}
{phang2}{cmd:.} {stata "ivmw, window(3950) par(b1): ivtsri y (x = z1 z2 z3), link(logit)"}{p_end}

{marker results}{...}
{title:Stored results}

{pstd}
Please see {help rolling##results}{p_end}

{marker references}{...}
{title:References}

{marker burgess}{...}
{phang}
Burgess S, Davies N, Thompson SG, EPIC-InterAct Consortium. 
Instrumental variable analysis with a nonlinear exposure-outcome relationship. 
Epidemiology, 2014, 25, 6, 877-885. 
{browse "https://doi.org/10.1097/ede.0000000000000161":DOI}
{p_end}

{marker manxtile}{...}
{phang}
StataCorp. Stata Base Reference Manual. Release 16. 
pctile - Creating variable containing percentiles. 2016. 
{browse "https://www.stata.com/manuals/dpctile.pdf":URL}
{p_end}

{marker author}{...}
{title:Author}

INCLUDE help ivonesamplemr-author
