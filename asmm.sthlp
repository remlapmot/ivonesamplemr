{smcl}
{* *! version 0.1.0  03sep2021 Tom Palmer}{...}
{vieweralsosee "onesamplemr" "help onesamplemr"}{...}
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
{cmd:asmm} is not a command but this helpfile is to say the additive structural mean model (ASMM) is simply fit with a linear IV estimator available in {help ivregress} and {help ivreg2}. 

{marker examples}{...}
{title:Examples}

{pstd}Using the data provided by {help mregger##do:Do et al. (2013)} recreate 
{help mregger##mrmedian:Bowden et al. (2016)}, Table 4, 
LDL-c "All genetic variants" estimates.{p_end}

{pstd}Setup{p_end}
{phang2}{cmd:.} {stata "use https://raw.github.com/remlapmot/mrrobust/master/dodata, clear"}{p_end}

{pstd}Select observations ({it:p}-value with exposure < 10^-8){p_end}
{phang2}{cmd:.} {stata "gen byte sel1 = (ldlcp2 < 1e-8)"}{p_end}

{pstd}IVW (with fixed effect standard errors){p_end}
{phang2}{cmd:.} {stata "mregger chdbeta ldlcbeta [aw=1/(chdse^2)] if sel1==1, ivw fe"}{p_end}

{pstd}MR-Egger (with SEs using an unconstrained residual variance){p_end}
{phang2}{cmd:.} {stata "mregger chdbeta ldlcbeta [aw=1/(chdse^2)] if sel1==1"}{p_end}

{pstd}MR-Egger reporting {it:I^2_GX} statistic and heterogeneity Q-test{p_end}
{phang2}{cmd:.} {stata "mregger chdbeta ldlcbeta [aw=1/(chdse^2)] if sel1==1, gxse(ldlcse) heterogi"}{p_end}

{pstd}MR-Egger using a t-distribution for inference & CI limits{p_end}
{phang2}{cmd:.} {stata "mregger chdbeta ldlcbeta [aw=1/(chdse^2)] if sel1==1, tdist"}{p_end}

{pstd}MR-Egger using the radial formulation{p_end}
{phang2}{cmd:.} {stata "mregger chdbeta ldlcbeta [aw=1/(chdse^2)] if sel1==1, radial"}{p_end}

{pstd}MR-Egger using the radial formulation and reporting heterogeneity Q-test{p_end}
{phang2}{cmd:.} {stata "mregger chdbeta ldlcbeta [aw=1/(chdse^2)] if sel1==1, radial heterogi"}{p_end}

{marker references}{...}
{title:References}

{marker bowden}{...}
{phang}
Bowden J, Davey Smith G, Burgess S. 
Mendelian randomization with invalid instruments: effect estimation and bias 
detection through Egger regression. International Journal of Epidemiology, 
2015, 44, 2, 512-525. 
{browse "http://dx.doi.org/10.1093/ije/dyv080":DOI}
{p_end}

{marker author}
{title:Author}

INCLUDE help onesamplemr-author
