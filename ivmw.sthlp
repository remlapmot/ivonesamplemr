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
{synopt:{opt par:}}Do not display exponentiated estimates{p_end}
{synopt:{opt window:}}Show the GMM iteration log{p_end}
{synopt:{opt rolling_options:}}{help rolling##options}{p_end}

{marker description}{...}
{title:Description}

{pstd}
{cmd:ivmw} implements the moving window (rolling window) approach to the estimator specified after the prefix. It is implemented as a call to {help rolling}.
 
{marker options}{...}
{title:Options}

{phang}
Please see {help rolling##options}

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

{pstd}Example MSMM fit.{p_end}

{phang2}{cmd:.} {stata "ivmw, window(2400) par(x): ivmsmm y (x = z1 z2 z3)"}{p_end}

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

{marker author}
{title:Author}

INCLUDE help ivonesamplemr-author
