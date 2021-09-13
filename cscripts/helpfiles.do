// render the helpfiles in the Results window, to check they are approx ok
// 2021-09-06

local helpfiles ///
ivonesamplemr ///
ivasmm ///
ivlsmm ///
ivmsmm ///
ivtsps ///
ivtsri ///
iv ///
ivmw

foreach helpfile of local helpfiles {
	type ../`helpfile'.sthlp
}
