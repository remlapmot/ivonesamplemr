// Test installation methods
// 2021-09-06

** net install

cap noi ado uninstall ivonesamplemr

net desc ivonesamplemr, from("https://raw.github.com/remlapmot/ivonesamplemr/main/")

net install ivonesamplemr, from("https://raw.github.com/remlapmot/ivonesamplemr/main/") replace
do https://raw.github.com/remlapmot/ivonesamplemr/main/dependency.do

** github package

cap noi ado uninstall ivonesamplemr

net install github, from("https://haghish.github.io/github/")
github install remlapmot/ivonesamplemr

cap noi ado uninstall ivonesamplemr
