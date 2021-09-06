// render the helpfiles in the Results window, to check they are approx ok
// 2021-09-06

local helpfiles ///
onesamplemr ///
asmm ///
lsmm ///
msmm ///
tsps ///
tsri

foreach helpfile of local helpfiles {
	type ../`helpfile'.sthlp
}
