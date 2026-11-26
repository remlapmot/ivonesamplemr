{smcl}
{* *! version 0.2.0  26nov2026 Tom Palmer}{...}
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
{opt iv} {it:subcommand} {it:...}

{p 4 4 2}
where {it:subcommand} is one of{p_end}

{synoptset 10}{...}
{synopt :{cmd:fsw}}{help ivfsw}{p_end}
{synopt :{cmd:lsmm}}{help ivlsmm}{p_end}
{synopt :{cmd:msmm}}{help ivmsmm}{p_end}
{synopt :{cmd:mw}}{help ivmw}{p_end}
{synopt :{cmd:tsps}}{help ivtsps}{p_end}
{synopt :{cmd:tsri}}{help ivtsri}{p_end}
{synopt :{cmd:xtile}}{help ivxtile}{p_end}
{synoptline}

{p 4 4 2}
and {it:...} is the syntax of that command, including any weights, {it:if}, {it:in}, and options.{p_end}

{marker description}{...}
{title:Description}

{pstd}
{cmd:iv} is a simple wrapper to the commands in the {help ivonesamplemr} package.

{pstd}
The {it:subcommand} is specified as the ivonesamplemr program name without its {cmd:iv} prefix, 
i.e. {cmd:ivlsmm ...} can alternatively be run using the syntax {cmd:iv lsmm ...}.
Everything after the {it:subcommand} is passed unchanged to that command.
 
{marker options}{...}
{title:Options}

{phang}
{cmd:iv} takes the options for the specified subcommand.

{marker examples}{...}
{title:Examples}

{phang2}{cmd:.} {stata "use https://raw.githubusercontent.com/remlapmot/ivonesamplemr/main/data/ivbinoutdata, clear"}{p_end}

{pstd}Fit the model with a single instrumental variable.{p_end}

{phang2}{cmd:.} {stata "iv lsmm y (x = z1)"}{p_end}

{phang2}{cmd:.} {stata "iv msmm y (x = z1 z2 z3)"}{p_end}

{phang2}{cmd:.} {stata "iv tsps y (x = z1 z2 z3), link(logit)"}{p_end}

{phang2}{cmd:.} {stata "iv tsri y (x = z1 z2 z3), link(logit)"}{p_end}

{pstd}Sanderson-Windmeijer conditional F-statistics after {cmd:ivregress}.{p_end}

{phang2}{cmd:.} {stata "ivregress 2sls y (x1 x2 = z1 z2 z3)"}{p_end}

{phang2}{cmd:.} {stata "iv fsw"}{p_end}

{pstd}Moving window and quantile analyses.{p_end}

{phang2}{cmd:.} {stata "iv mw, window(2400) par(x): ivregress 2sls y (x = z1 z2 z3)"}{p_end}

{phang2}{cmd:.} {stata "iv xtile, nq(4) par(x): ivregress 2sls y (x = z1 z2 z3)"}{p_end}

{marker results}{...}
{title:Stored results}

{pstd}
{cmd:iv} returns the results from the specified subcommand.

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
