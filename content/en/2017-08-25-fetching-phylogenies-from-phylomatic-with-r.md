---
title: Fetching phylogenies from Phylomatic with R
date: '2017-08-25'
slug: r-phylomatic
---

It is usually a good idea to control for species evolutionary history if we want to get robust results. This is because species are not independent from each other, thus violate the independence assumption of data for most statistical models. Fortunately, with growing available genetic data and softwares, building phylogenies are getting easier and easier. 

[Phylomatic](http://phylodiversity.net/phylomatic/) is an easy way to fetch phylogenies for species, especially plants, on line. Thanks to packages developed by [rOpenSci](https://ropensci.org), we can now use Phylomatic within R. One big advantage of this is reproducibility, which means that we can regenerate the phylogeny whenever we want without click on buttons on the website. In addition, because most ecologists are using R for downstream analyses, fetching phylogenies within R will make the workflow much natural and easy to follow.

The basic procedure for fetching phylogenies with Phylomatic using R will be:

1. Compile the species names we want to include in the phylogeny; and clean if necessary (`taxize` package, `rotl::tnrs_match_names()`)
2. Clean and prepare species names in the format to be used with Phylomatic (`brranching::phylomatic_names()`)
3. Query Phylomatic and return the phylogeny (`brranching::phylomatic()`; if you have hundreds species, it is better to use Phylomatic locally with `brranching::phylomatic_local()`)^[Another option to use Phylomatic locally is to download Phylocom, which can also be used within R using package [`phylocomr`](https://github.com/ropensci/phylocomr)]

It is possible to merge step 2 and 3, but I prefer to separate them.

I assume that you already have a list of species, named as `sp_list`. Then we can use the `phylomatic()` function from the `brranching` package. If you do not have it installed, install it first with `install.packages("brranching")`.

```r
sp_list = c()
tree = brranching::phylomatic(sp_list)
```

If you have few species, this will likely give you a phylogeny with all species. However, in practice, it is quite possible that you will get a warning like this:

    NOTE: 3 taxa not matched: NA/genus/species, ...

In this case, we may try to prepare species names first with `brranching::phylomatic_names()`. The default database will be `ncbi`, but if you have hundreds of species, this can be slow. Instead, I would suggest to use `ape` first because it is much faster (this is the default within `brranching::phylomatic()`). Then filter out those species have `NA` as family and try `ncbi` or `itis` (these are the three database supported). Sometimes, your species names are not clean, e.g. with synonyms, then the R package `taxize` will be really handy. In addition, I find `rotl::tnrs_match_names()` is also good to check and solve names. This function will compare with [Open Tree of Life](https://tree.opentreeoflife.org/opentree/argus/opentree9.1@ott93302) to check species names.

```r
sp_list_phylocom = brranching::phylomatic_names(sp_list, 
                                                format = "isubmit", 
                                                db = "ncbi")
```

Now, let's try to fetch the phylogeny again, with the updated species list.

```r
tree = brranching::phylomatic(sp_list_phylocom)
```

As mentioned eariler, it is possible to merge these two steps into one with `tree = brranching::phylomatic(sp_list_phylocom, db = "ncbi")` but I prefer to solve species names first.

The default backbone phylogeny is the APG III `R20120829`. We can use the Zanne et al. 2014 phylogeny.

```r
tree = brranching::phylomatic(sp_list_phylocom, 
                              storedtree = "zanne2014")
plot(tree)
```

Finally, I have one reproducible example that shows how to use the `brranching` package to get phylogeny for plants at [Github](https://github.com/daijiang/New_Phytologist_Appendix/blob/master/1-data.R). Feel free to check it out (and the associated [paper](http://onlinelibrary.wiley.com/doi/10.1111/nph.14397/abstract) if you are interested in)!
