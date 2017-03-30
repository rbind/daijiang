---
title:  Reading and plotting phylogenetic data in R
date: '2014-05-03'
slug: notes-func-phylo-book-0
---
> This is my reading notes for *Functional and Phylogenetic Ecology in R* by Nathan Swenson. All credits go to Nathan.  
> This post will be updated later when I learn more about this topic.

# Chapter 2: Reading and plotting tree.

Possible packages needed.

```r
install.packages(c("picante", "phylobase", "phylotools", "ecodist", "FD", 
"adephylo", "geiger"))
lapply(c("picante", "phylobase", "phylotools", "ecodist", "FD", "adephylo", 
    "geiger"), library, character.only = T)
```


##Data reading

Get data at [here](http://link.springer.com/chapter/10.1007%2F978-1-4614-9542-0_2).

```r
library(ape)
my.phylo = read.tree("data/my.phylo.newick.file.txt")  # read.tree()
my.phylo
is.ultrametric(my.phylo)  # is.ultrametric()
plot(my.phylo, cex = 0.5)
add.scale.bar(length = 0.1)
plot.phylo(my.phylo, type = "fan")  # plot.phylo()
nodelabels(frame = "none", cex = 0.8)
tiplabels()
```


## Prun tree


```r
my.subtrees = subtrees(my.phylo)  # subtrees() to subset
my.subtrees[[15]]
# subtreeplot(my.phylo)
plot(my.subtrees[[15]])
drop.tree = drop.tip(my.phylo, c("e", "j"))  # drop.tip() to prun tree
plot(drop.tree)
# extract.clade(my.phylo, interactive = T)
```


## Polynomy


```r
my.poly.phylo = read.tree("data/example.poly.txt")
my.poly.phylo
plot(my.poly.phylo)
my.di.phylo = multi2di(my.poly.phylo)  # multi2di() 
my.di.phylo
plot(my.di.phylo)
```
`multi2di()` solves the polynomy by randomly add a zero length branch within the polynomy.


## Branching time


```r
branching.times(my.phylo)
```
`branching.times()` returns branch times for all internodes, ordered from root to tips.

## Phylo distance between pairs of terminal taxa


```r
p.dist.mat = cophenetic(my.phylo)
vcv(my.phylo)
```

+ `cophenetic()` returns a phylogenetic distance species by species matrix. Values in the matrix are the sum of the branch lengths separating each pair of species.
+ `vcv()` returns a species by species matrix also. But it is a phylogenetic variance-covariance (VCV) matrix. Diagonal values are the distance from the root to the tip; off-diagonal values are the amount of shared branch length between pairs of species. Or you can think it as a correlation matrix. The larger the values, the closer the species.  


## Simulating phylogenies in R

There are two common methods. Consider the assumptions when choose simulation method.

+ Randomly split the edges. Begin with a single branch that randomly splits into two daughter branches, and the daughter branches may then branch into two, and so on. 

```r
new.tree = rtree(n = 40, rooted = T)  # can provide tip.label=c(sp, sp,...)
plot(new.tree)
```

+ Randomly cluster the tips.

```r
new.ultra.tree = rcoal(40)
plot(new.ultra.tree)
write.tree(new.ultra.tree, "name.txt")
```
