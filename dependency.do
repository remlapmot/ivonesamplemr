// dependencies for onesamplemr package
// Tom Palmer 2021-09-04

foreach prog in ivpois ivreg2 ranktest {
    // note: ranktest is a dependency of ivreg2
	cap noi ssc install `prog'
	if _rc == 602 {
		di as txt "Installing the latest version of `prog'"
		ssc install `prog', replace
	}
}
