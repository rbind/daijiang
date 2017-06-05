---
title:  Phylogenetic and functional beta diversity
date: '2014-05-17'
slug: phylogenetic-functional-beta-diversity
---

It is important to study phylogenetic and functional beta diversity as well as taxonomic beta diversity. This is because that phylogenetic and functional beta diversity are not necessary have the same trend as taxonomic beta diversity.

Example data can be found at [here](http://link.springer.com/chapter/10.1007%2F978-1-4614-9542-0_5)

# Tree-based measures of phylogenetic beta diversity

The following metrics have been usually used on phylogenetic trees, but could potentially be used on dendrograms constructed from trait data.

## UniFrac

UniFrac is the first tree-based metric for phylogenetic and functional beta diversity. It seeks to quantify the unique fraction of the phylogeny contained in each of the two communities being compared.
`\[
UniFrac_{A,B}=\frac{PD_{A\cup B}-PD_{A\cap B}}{PD_{A\cup B}}
\]`
The unweighted UniFrac can be calculated by `unifrac()` in the `picante` package.

```r
library(ape)
library(picante)
my.sample = read.table("data/beta.example.sample.txt", sep = "\t", row.names = 1, 
    header = T)
my.phylo = read.tree("data/beta.example.phylo.txt")
traits = read.table("data/beta.example.traits.txt", sep = "\t", row.names = 1, 
    header = T)
unifrac(my.sample, my.phylo)
```

A improved version of UniFrac can use species relative abundace as weight, but the weighted unifrac does not eqaul the value from the original unifrac calculation if abundances become presence/absence. That is, the weighted metrics is not a natural extension of the original one and they are not cohorent. A solution to this problem was provided by Chen et al 2012 and was included in the `GUniFrac` package. (P.S. I just do not like upper letters in package names!)

```r
# install.packages('GUniFrac')
library(GUniFrac)
GUniFrac(my.sample, my.phylo, alpha = c(0.5, 1))
```


## Phylogenetic Sorenson's index

The unifrac index above is a dissimilarity index while this one is a similarity one. They are highly correlated (monotonic) with each other.

$$PhyloSor=2\times\frac{bl_{AB}}{bl_{A}+bl_{B}}$$

where `\(bl_{AB}\)` is the Faith's index of the species shared between
two communities A and B, while `\(bl_{A}\)` and `\(bl_{B}\)` are the Faith's
index for the two communities.

The phylogenetic sorenson index can be calculated by `phylosor()` function in the `picante` package.

```r
phylosor(my.sample, my.phylo)
```


# Distance-based measures of phylogenetic and functional beta diversity

The distance-based measures of beta diversity are more preferable for most analyses compare with tree-based ones. They are faster to compute, are able to handlw phylogenetic and functional information. Since most published indices are highly correlated with each other, we will focus on one general type of pairwise and one general type of nearest neighbor matric.

## Pairwise measures

The pairwise phylogenetic or trait distance (abundance weighted and unweighted) between communities can be calculated by using the `comdist()` function in the `picante` package.

```r
comdist(my.sample, cophenetic(my.phylo), abundance.weighted = F)
```


## Nearest neighbor measures

$$D_{nn}=\frac{\sum_{i}^{n_{k_{1}}}min\delta_{ik_{2}}+\sum_{j}^{n_{k_{2}}}min\delta_{jk_{1}}}{n_{k_{1}}+n_{k_{2}}}$$

where `\(min\delta_{ik_{2}}\)` is the minimum phylogenetic distance between
species *i* in community `\(k_{1}\)` and all species in community `\(k_{2}\)`.
Similar for `\(min\delta_{jk_{1}}\)`. *n* is the number of species in the
respective communities.
This index can be calculated using the `picante` package as:

```r
comdistnt(my.sample, cophenetic(my.phylo), abundance.weighted = FALSE, exclude.conspecifics = FALSE)
```


## Rao

We can calculate Rao's dissimilarity metrics using `raoD()` function in the `picante` package.

```r
rao.output = raoD(my.sample, my.phylo)
# among community diversity
rao.output$Dkl  # really confuse! Upper D, lower k, and lower l (not number 1)...
```


