# Simple R Markdown website for ivonesamplemr package

Install the R dependencies with

```r
if (!requireNamespace("Statamarkdown")) {
  if (!requireNamespace("remotes")) install.packages("remotes")
  remotes::install_github("Hemken/Statamarkdown")
}
if (!requireNamespace("rmarkdown")) install.packages("rmarkdown")
```

To install the Stata dependencies run in Stata
```stata
do ../dependency.do
```

To build the website, either open the project in RStudio and in the *Build* pane click *Build Website*, or run in R
```r
rmarkdown::render_site(encoding = 'UTF-8')
```