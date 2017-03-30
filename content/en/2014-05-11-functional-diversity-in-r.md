---
title:  Functional diversity in R
date: '2014-05-11'
slug: functional-diversity-in-r
---

>This is my reading notes for *Functional and Phylogenetic Ecology in R* by Nathan Swenson. All credits go to Nate.  
This post will be updated later when I learn more about this topic.

```r
my.sample.4 = read.table("data/FD.example.sample.txt", header = T, row.names = 1)
traits = read.table("data/FD.traits.txt", sep = "\t", header = T, row.names = 1)
```

## Moments of functional traits.
It is easy to calculate moments (e.g., mean, standard deviation, skewness, kurtosis). For skeness and kurtosis, we need function `skewness()` and `kurtosis()` in the `fBasics` package. High skewness may indicate that most co-occurring species tend to have similar trait values.

For community weighted trait mean (CWM), we just weighted functional trait by the *relative abundance* of each species. For this, we can use:

```r
weighted.mean(trait1.sp, abundance.sp)  # they need have same length.
library(SDMtools)  # for wt.sd()
wt.sd(trait1.sp, abundance.sp)  # weighted standard deviation of trait1
```

## Dendrogram-based VS Euclidean distance-based meansures of FD

The branch length information comes from a dendrogram generated with hierarchical clustering with a Euclidean trait distance matrix as input.

### Trait distance matrices

```r
# distance matrix for trait 2. It is useful to analyze individual traits.
my.dist.mat.2 = dist(as.matrix(traits[, 2]), method = "euclidean")
# distance matrix using all traits
dist(traits, method = "euclidean")
```

It is **recommended** to first transform the trait data, e.g. log-transform to make trait data normal and then scale them to the same scale. Then using PCA to reduce redundancy. The PCA part, I think, is optional, though it reduced trait matrix into orthognal axes. After PCA, one can also look at individual axis of PCA, treat them as individual trait.

```r
# assuming that all traits are continuous data and no NAs.
traits.scaled = apply(log(traits), 2, scale)
pc = princomp(traits.scaled)  # stats package
# pc=rda(traits.scaled) # vegan package
summary(pc)
pc.scores = pc$scores[, 1:3]  # the first 3 axes
pc.dist.mat = dist(pc.scores, method = "euclidean")
```

But, it is very common that we have both continuous and categorical traits as well as NAs in the data. In this case, one can use Gower distance: `gowdis()` from the `FD` package.

```r
library(FD)
gowdis(traits)
```

### Trait dendrograms

The first step is to build a distance matrix as the above section. Then using hierarchical clustering to divide clusters among species. The most common method is an Unweighted Pair Group Method with Arithmetic Mean (UPGMA). It will identify the two closest species in the trait distance matrix and put them in a cluster. Then calculate the two closest species in the remaining species to be the second cluster. So forth and so on. The branch lengths in the resulting dendrogram between two clusters can be calculated as:
`\[
cluster\, dist=\frac{\sum_{i}^{A}\sum_{j}^{B}d_{ij}}{A\times B}
\]`
where there are A species in cluster 1 and B species in cluster 2.

```r
my.dist = dist(traits, method = "euclidean")  # using all traits
# you can also use one trait per time
my.dendro = hclust(my.dist, method = "average")
plot(my.dendro)
```

### Pairwise and nearest neigbor measures

The method to calculate pairwise and nearest neigbor measures for functional traits is same as those for phylogenetic diversity. For FD, we need to decide to use the dendrogram or the raw distance matrix as input. If using dendrogram, we need change it into a distance matrix first `cophenetic(my.dendro)` which may will lose information. As a result, the recommendation is to use the raw distance matrix as input.

```r
# library(picante)
square.dist.mat = as.matrix(pc.dist.mat)
dimnames(square.dist.mat) = list(names(my.sample.4), names(my.sample.4))
mpd(my.sample.4, square.dist.mat, abundance.weighted = F)
# unweighted. abundance.weighted = T for weighted.
mntd(my.sample.4, square.dist.mat, abundance.weighted = F)
# mean nearest neighbor distance
mntd(my.sample.4, square.dist.mat, abundance.weighted = F)
```

### Ranges and Convex Hulls (FRic), FDiv, FEve, and FDis
The convex hull volume for a community is now commonly referred as FRic.

```r
library(geometry)
convhulln(traits[names(my.sample.4[1, my.sample.4[1, ] > 0]), ])
# convex hull for community 1.
library(FD)
fundiv = dbFD(traits, my.sample.4)
fundic$FRic
# convex hulls for all communities
```

The `dbFD()` function will perform an initial test to determine whether the trait data require a reduction in dimensionality. If so, it will remove redundant dimensions for you. But for other analyses, it is advised to test and reduce dimensionality by youself.

The `dbFD()` returns the three FD indices of Villéger et al. (2008): functional richness (FRic), functional evenness (FEve), and functional divergence (FDiv), as well functional dispersion (FDis; Laliberté and Legendre 2010), Rao's quadratic entropy (Q) (Botta-Dukát 2005), a posteriori functional group richness (FGR) (Petchey and Gaston 2006), and the community-level weighted means of trait values (CWM; e.g. Lavorel et al. 2008). `?dbFD()` for more details.
