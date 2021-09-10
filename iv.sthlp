{smcl}
{* *! version 0.1.0  10sep2021 Tom Palmer}{...}
{vieweralsosee "ivonesamplemr" "help ivonesamplemr"}{...}
{viewerjumpto "Syntax" "iv##syntax"}{...}
{viewerjumpto "Description" "iv##description"}{...}
{viewerjumpto "Options" "iv##options"}{...}
{viewerjumpto "Examples" "iv##examples"}{...}
{viewerjumpto "Stored results" "iv##results"}{...}
{viewerjumpto "Author" "iv##author"}{...}
{title:Title}

{p 5}
{bf:iv} {hline 2} Instrumental variable (IV) programs useful for one-sample Mendelian randomization (MR) analyses
{p_end}

{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{opt iv} {it:subcommand} ... [{it:aweight}] {ifin} [{cmd:,} {it:options}]

{marker description}{...}
{title:Description}

{pstd}
{cmd:iv} is a simple wrapper to the commands in the {help ivonesamplemr} package.

{pstd}
The {it:subcommand} is specified as the mrrobust program name without its {cmd:iv} prefix, i.e. {cmd:ivlsmm ...} can alternatively be run using the syntax {cmd:iv lsmm ...}.
 
{marker options}{...}
{title:Options}

{phang}
{cmd:iv} takes the options for the specified subcommand.

{marker examples}{...}
{title:Examples}

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

{phang2}{cmd:.} {stata "iv lsmm y (x = z1)"}{p_end}

{phang2}{cmd:.} {stata "iv msmm y (x = z1 z2 z3)"}{p_end}

{phang2}{cmd:.} {stata "iv tsps y (x = z1 z2 z3)"}{p_end}

{phang2}{cmd:.} {stata "iv tsri y (x = z1 z2 z3), link(logit)"}{p_end}

{marker results}{...}
{title:Stored results}

{pstd}
{cmd:iv} returns the results from the specified subcommand.

{marker author}
{title:Author}

INCLUDE help ivonesamplemr-author
