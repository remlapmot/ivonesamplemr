{smcl}
{* *! version 1.1.0  26nov2026 Tom Palmer}{...}
{vieweralsosee "ivonesamplemr" "help ivonesamplemr"}{...}
{vieweralsosee "ivregress" "help ivregress"}{...}
{vieweralsosee "ivreg2" "help ivreg2"}{...}
{viewerjumpto "Syntax" "ivfsw##syntax"}{...}
{viewerjumpto "Description" "ivfsw##description"}{...}
{viewerjumpto "Examples" "ivfsw##examples"}{...}
{viewerjumpto "Stored results" "ivfsw##results"}{...}
{viewerjumpto "References" "ivfsw##references"}{...}
{viewerjumpto "Author" "ivfsw##author"}{...}
{title:Title}

{p 5}
{bf:ivfsw} {hline 2} Conditional F-statistics of Sanderson and Windmeijer (2016)
{p_end}

{marker syntax}{...}
{title:Syntax}

{p 8 14 2}
{cmd:ivfsw}

{pstd}
{cmd:ivfsw} is a postestimation command for use after {help ivregress} or {help ivreg2}.

{marker description}{...}
{title:Description}

{pstd}
{cmd:ivfsw} calculates the conditional F-statistic of {help ivfsw##sanderson:Sanderson and Windmeijer (2016)}
for each endogenous variable (exposure) in the model most recently fitted by {help ivregress} or {help ivreg2}.
The conditional F-statistic for an exposure tests whether it is weakly identified given the other exposures,
and is used to assess instrument strength in models with multiple exposures, such as in multivariable
Mendelian randomization.

{pstd}
For each exposure, {cmd:ivfsw} fits the conditional model of the exposure regressed on the other exposures
and the exogenous variables, with the other exposures instrumented by the excluded instruments, and then
computes the F-statistic of the excluded instruments in the regression of the residuals of the conditional
model on the excluded instruments and exogenous variables. The conditional F-statistic is this
F-statistic multiplied by L/(L - K + 1), where L is the number of excluded instruments and K the number of
exposures, and has L - K + 1 numerator degrees of freedom. With a single exposure it is the usual first
stage F-statistic for the excluded instruments.

{pstd}
The conditional F-statistics can be compared with the {help ivfsw##stock:Stock and Yogo (2005)} critical
values for a single exposure with L - K + 1 instruments. They are the same as the conditional F-statistics
calculated by the {cmd:fsw()} function in the R package
{browse "https://CRAN.R-project.org/package=OneSampleMR":OneSampleMR}, and as the Sanderson-Windmeijer
F-statistics reported by {help ivreg2} with the {cmd:first} option.

{pstd}
{cmd:ivfsw} uses the weights and the variance type of the fitted model. After a model fitted with robust or
one-way cluster-robust standard errors (including with {it:pweight}s) the F-statistics are robust
versions, and after a model with weights the conditional models and F-tests are weighted, in each case
matching {help ivreg2}. With cluster-robust standard errors the denominator degrees of freedom are the
number of clusters minus one. Note that the Stock and Yogo (2005) critical values were derived for the
non-robust F-statistic. HAC, two-way cluster-robust, bootstrap, and jackknife variances, and the
{cmd:partial()}, {cmd:dofminus()}, and {cmd:sdofminus()} options of {cmd:ivreg2}, are not supported.

{marker examples}{...}
{title:Examples}

{pstd}Read in binary outcome data; y outcome, x1 and x2 exposures, w covariate, z* instrumental variables (genotypes).{p_end}

{phang2}{cmd:.} {stata "use https://raw.githubusercontent.com/remlapmot/ivonesamplemr/main/data/ivbinoutdata, clear"}{p_end}

{pstd}Conditional F-statistics after {cmd:ivregress}.{p_end}

{phang2}{cmd:.} {stata "ivregress 2sls y w (x1 x2 = z1 z2 z3)"}{p_end}
{phang2}{cmd:.} {stata "ivfsw"}{p_end}

{pstd}Conditional F-statistics after {cmd:ivreg2}.{p_end}

{phang2}{cmd:.} {stata "ivreg2 y w (x1 x2 = z1 z2 z3)"}{p_end}
{phang2}{cmd:.} {stata "ivfsw"}{p_end}

{pstd}Robust conditional F-statistics.{p_end}

{phang2}{cmd:.} {stata "ivregress 2sls y w (x1 x2 = z1 z2 z3), vce(robust)"}{p_end}
{phang2}{cmd:.} {stata "ivfsw"}{p_end}

{marker results}{...}
{title:Stored results}

{pstd}
{cmd:ivfsw} stores the following in {cmd:r()}:{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:r(N)}}number of observations{p_end}
{synopt:{cmd:r(K)}}number of exposures (endogenous variables){p_end}
{synopt:{cmd:r(L)}}number of excluded instruments{p_end}

{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:r(vce)}}variance type used: {cmd:unadjusted}, {cmd:robust}, or {cmd:cluster-robust (}{it:clustvar}{cmd:)}{p_end}

{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:r(table)}}conditional F-statistics, numerator and denominator degrees of freedom, and
p-values, with one row for each exposure{p_end}

{marker references}{...}
{title:References}

{marker sanderson}{...}
{phang}
Sanderson E, Windmeijer F.
A weak instrument F-test in linear IV models with multiple endogenous variables.
Journal of Econometrics, 2016, 190, 2, 212-221.
{browse "https://doi.org/10.1016/j.jeconom.2015.06.004":DOI}
{p_end}

{marker stock}{...}
{phang}
Stock JH, Yogo M.
Testing for weak instruments in linear IV regression.
In Andrews DWK, Stock JH (eds.), Identification and Inference for Econometric Models: Essays in Honor of
Thomas Rothenberg. 2005. Cambridge University Press, Cambridge. 80-108.
{browse "https://doi.org/10.1017/CBO9780511614491.006":DOI}
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
