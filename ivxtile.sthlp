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
{bf:ivxtile} {hline 2} Perorm estimation within quantiles of the first stage residuals prefix command
{p_end}

{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{cmd:ivxtile} {cmd:,} {opt window(#)} {opt par(string)} [{opt sa:ving(string)} {opt rolling_options}]{cmd::} {it:iv_cmd}

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{synopt:{opt par:(string)}}Parameter from the {it:iv_cmd} (ivreg2, ivmsmm, ivlsmm, ivtsps, ivtsri) to collect{p_end}
{synopt:{opt sa:ving(string)}}Save the moving window output to a dataset. 
Specify {cmd:, replace} to overwrite an existing dataset{p_end}
{synopt:{opt rolling_options:}}{help rolling##options}{p_end}

{marker description}{...}
{title:Description}

{pstd}
{cmd:ivxtile} implements the command specified after the prefix within quantiles of the first stage residuals, 
as per {help ivxtile##burgess:Burgess et al., 2014}. 
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

{pstd}Use with different iv commands.{p_end}

{phang2}{cmd:.} {stata "ivxtile, nq(5) par(x): ivregress 2sls y (x = z1 z2 z3)"}{p_end}
{phang2}{cmd:.} {stata "ivxtile, nq(5) par(x): ivtsps y (x = z1 z2 z3), link(logadd)"}{p_end}
{phang2}{cmd:.} {stata "ivxtile, nq(5) par(x): ivtsps y (x = z1 z2 z3), link(logit)"}{p_end}
{phang2}{cmd:.} {stata "ivxtile, nq(5) par(x): ivlsmm y (x = z1 z2 z3)"}{p_end}
{phang2}{cmd:.} {stata "ivxtile, nq(5) par(x): ivmsmm y (x = z1 z2 z3)"}{p_end}

{pstd}Save the dataset of results.{p_end}

{phang2}{cmd:.} {stata "ivxtile, nq(10) par(x) saving(ivxtileres): ivreg2 y2 (x = g)"}{p_end}

{marker results}{...}
{title:Stored results}

{pstd}
{cmd:ivxtile} does not store results.{p_end}

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
