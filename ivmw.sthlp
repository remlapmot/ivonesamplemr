{smcl}
{* *! version 0.1.0  12sep2021 Tom Palmer}{...}
{vieweralsosee "ivonesamplemr" "help ivonesamplemr"}{...}
{vieweralsosee "rolling" "help rolling"}{...}
{viewerjumpto "Syntax" "ivmw##syntax"}{...}
{viewerjumpto "Description" "ivmw##description"}{...}
{viewerjumpto "Options" "ivmw##options"}{...}
{viewerjumpto "Examples" "ivmw##examples"}{...}
{viewerjumpto "Stored results" "ivmw##results"}{...}
{viewerjumpto "References" "ivmw##references"}{...}
{viewerjumpto "Author" "ivmw##author"}{...}
{title:Title}

{p 5}
{bf:ivmw} {hline 2} Moving window prefix command
{p_end}

{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{cmd:ivmw} {cmd:,} {opt window(#)} {opt par(string)} [{opt rolling_options}]{cmd::} {it:iv_cmd}

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{synopt:{opt par:}}Parameter from the {it:iv_cmd} (ivreg2, ivmsmm, ivlsmm, ivtsps, ivtsri) to collect{p_end}
{synopt:{opt window:}}number of consecutive data points in each sample{p_end}
{synopt:{opt rolling_options:}}{help rolling##options}{p_end}

{marker description}{...}
{title:Description}

{pstd}
{cmd:ivmw} implements the moving window (a.k.a. sliding / rolling window) approach to the estimator specified after the prefix, as per {help ivmw##burgess:Burgess et al., 2014}. It is implemented as a call to {help rolling}.
 
{marker options}{...}
{title:Options}

{phang}
Please see {help rolling##options}

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

{marker results}{...}
{title:Stored results}

{pstd}
Please see {help rolling##results}{p_end}

{marker references}{...}
{title:References}

{marker burgess}{...}
{phang}
Burgess S, Davies N, Thompson SG, EPIC-InterAct Consortium. Instrumental variable analysis with a nonlinear exposure-outcome relationship. Epidemiology, 2014, 25, 6, 877-885. 
{browse "https://doi.org/10.1097/ede.0000000000000161":DOI}
{p_end}

{marker manrolling}{...}
{phang}
StataCorp. Stata Base Reference Manual. Release 16. rolling - Rolling-window and recursive estimation. 2016. 
{browse "https://www.stata.com/manuals/tsrolling.pdf":URL}
{p_end}

{marker author}{...}
{title:Author}

INCLUDE help ivonesamplemr-author
