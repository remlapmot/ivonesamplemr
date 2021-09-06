// Test installation methods
// 2021-09-06

** net install

cap noi ado uninstall onesamplemr

net desc onesamplemr, from("https://raw.github.com/remlapmot/onesamplemr-stata/main/")

net install onesamplemr, from("https://raw.github.com/remlapmot/onesample-mr/main/") replace
do https://raw.github.com/remlapmot/onesample-mr/main/dependency.do

** github package

cap noi ado uninstall onesamplemr

net install github, from("https://haghish.github.io/github/")
github install remlapmot/onesamplemr-stata, package(onesamplemr)

cap noi ado uninstall onesamplemr
