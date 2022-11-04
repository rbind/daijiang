---
title: Host R packages on r-universe
date: '2022-09-30'
slug: r-universe
---

# The problem

Here is the problem: I am developing an R package [`rtrees`](https://github.com/daijiang/rtrees), which depends on a data package [`megatrees`](https://github.com/daijiang/megatrees) with size around 100 Mb. It is not possible to submit the data package to CRAN given its large size. In addition, CRAN does not allow packages with `Remotes` field (i.e., your package cannot depends on a package on GitHub). Therefore, I cannot submit `rtrees` to CRAN.

# Solution

After searching around, I came across the [R-universe program](https://r-universe.dev/search/) by rOpenSci. R-unierse allow us to build binary files for R packages and host it online; basically, we can have our own personal CRAN-like repo to host binaries for R packages without much trouble by following [its instruction](https://ropensci.org/blog/2021/06/22/setup-runiverse/). Now, my data package is on [my r-universe](https://daijiang.r-universe.dev/ui#packages). And in the `DESCRIPTION` file of `rtrees`, I can replace `Remotes` with the following line:

```
Additional_repositories: 
    https://daijiang.r-universe.dev
```

I think this should allow me to submit `rtrees` to CRAN in the future. Since R-universe build binaries for the R packages we put there (Mac and Windows), it is now pretty fast to install large packages.

# Shinny App

When I deploy the [Shiny app of `rtrees`](https://djli.shinyapps.io/rtrees_shiny/), shinyapps.io does not recognize r-universe and returned an error. To deploy it, I need to reinstall the package from GitHub using `remotes::install_github()`. This is because when deploying the shinny app, R will use the same way that you have installed the packages locally. If I installed the package from r-universe, R will try to do the same thing when deploying the shinny app; if I installed the package from GitHub, R will also install it from GitHub when deploying the shinny app. 



