---
title:  Null models for phylogenetic and functional analysis
date: '2014-05-29'
slug: null-model-for-phylogenetic-functional-diversity
---
> This is my reading notes for *Functional and Phylogenetic Ecology in R* by Nathan Swenson.  
You can get data from [here](http://link.springer.com/chapter/10.1007%2F978-1-4614-9542-0_6)


# Null models

When conducting null modeling analyses, it is critical to:

+ obey the first rule that to fix all observed patterns in the randomization except the pattern of interest.
+ be congnizant of the interaction between type I and type II error rates, and the degree of constraint imposed in the null model.

Phylogenetic diversity (PD) and functional diversity (FD) usually correlated with species richness (SR) in the community. As a result, it is hard to tell whether differences in PD/FD are real or just because of differences in SR. Metrics of PD/FD that uncorrelated (mostly pairwise calculations such as FDis, MPD, Rao's, PSV) with SR were proposed in literature but their variance varied with SR: high variance at low SR while low variance (decrease in the range of possible values) at high SR. As a result, they are not truely uncorrelated with SR. For these reasons, **null models** are advised for *any* analysis that using PD/FD values for inference, including those that are uncorrelated with SR.


```r
library(picante)
library(ape)
pd.sample = readsample("data/null.pd.example.sample.txt")
pd.phylo = read.tree("data/null.pd.example.phylo.txt")
faith.output = pd(pd.sample, pd.phylo)
```


Standardized effect size (`SES = (obs - mean(null))/sd(null)`) is an effective way for comparing the PD/FD of the communities while removing biases associated with differences in SR. It is better to report both SES and quantile (p-value).

## Classes of null models

1. To randomize the community data matrix (site by species) itself and does not alter the phylogenetic tree or the trait data matrix.
2. To randomize the phylogenetic tree or trait data matrix while fixing the observed community data matrix.

### Randomizing community data matrices

```r
com.data = matrix(c(1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 1), 3)
rownames(com.data) = c("com1", "com2", "com3")
colnames(com.data) = LETTERS[1:6]
library(picante)
# fix site species richness but not species incidence
reps = replicate(5, randomizeMatrix(com.data, null.model = "richness"))
apply(reps, 3, rowSums)
```

```
##      [,1] [,2] [,3] [,4] [,5]
## com1    4    4    4    4    4
## com2    4    4    4    4    4
## com3    4    4    4    4    4
```

```r
apply(reps, 3, colSums)
```

```
##   [,1] [,2] [,3] [,4] [,5]
## A    2    2    1    2    2
## B    3    1    3    2    1
## C    3    2    1    2    3
## D    1    2    2    2    2
## E    1    2    2    2    2
## F    2    3    3    2    2
```

```r
# fix site species richness and species incidence
reps.is = replicate(5, randomizeMatrix(com.data, null.model = "independentswap"))
apply(reps.is, 3, rowSums)
```

```
##      [,1] [,2] [,3] [,4] [,5]
## com1    4    4    4    4    4
## com2    4    4    4    4    4
## com3    4    4    4    4    4
```

```r
apply(reps.is, 3, colSums)
```

```
##   [,1] [,2] [,3] [,4] [,5]
## A    2    2    2    2    2
## B    1    1    1    1    1
## C    3    3    3    3    3
## D    2    2    2    2    2
## E    3    3    3    3    3
## F    1    1    1    1    1
```

```r
# abundance data
com.data.a = matrix(c(3, 0, 2, 0, 10, 0, 4, 2, 3, 4, 5, 0, 6, 1, 2, 0, 0, 7), 
    3)
rownames(com.data.a) = c("com1", "com2", "com3")
colnames(com.data.a) = LETTERS[1:6]
# abundance data
reps.is.a = replicate(5, randomizeMatrix(com.data.a, null.model = "independentswap"))
apply(reps.is.a, 3, rowSums)
```

```
##      [,1] [,2] [,3] [,4] [,5]
## com1   25   22   22   17   18
## com2    9   15   11   14   20
## com3   15   12   16   18   11
```

```r
apply(reps.is.a, 3, colSums)
```

```
##   [,1] [,2] [,3] [,4] [,5]
## A    5    5    5    5    5
## B   10   10   10   10   10
## C    9    9    9    9    9
## D    9    9    9    9    9
## E    9    9    9    9    9
## F    7    7    7    7    7
```

```r
# species abundance constent, but site total abundance varied!
```

When using null models on abundance data, it may be very hard to fix all obsrved properties aside from the one we are interested, as shown by the above example.

### Randomizing phylogenetic data

Even the most constrained randomization of community data matrix may will change other patterns except the one we are interested. It is hard to determine whether the results from community data matrix randomization are unbiased and only informing about the pattern of interest. As a result, when asking about whether my community has a higher phylogenetic diversity than expected, we do **not** randomize communities. Instead, we randomize the phylogenetic distances between species in our community. This keeps all patterns in the community data matrix and is simper and faster than community data randomization.

#### Unconstrained randomization

The **ultimate unconstrained** phylogenetic randomization would be to simulate phylogenetic trees that contain the same number of species in your data. But this method randomizes the overall ranking of relatedness of species (the topology) as well as the distribution of relatedness between species (the distribution of branch lengths). As a result, it is **not recommended**.

Instead, we can randomize the names of species on the phylogeny (the taxa names on the tips or terminal branches on the phylogeny). This will keep actual branch lengths and their distribution. To do this, we can first get the tip names and then randomize them and put them back to the phylogeny. This can be done with the `tipShuffle()` function in `picante` package.

```r
tips = pd.phylo$tip.label  # get the tip names
my.phylo.rand = pd.phylo  # copy the tree
# rename the copied tree.
my.phylo.rand$tip.label = sample(tips, length(tips), replace = F)

# Or just use function from picante
my.phylo.rand2 = tipShuffle(pd.phylo)
```


We can use these null models to calculate the null distribution of PD and get the SES and p-value for each site.

```r
rand.mpd.fun = function(x) {
    mpd(pd.sample, cophenetic(tipShuffle(x)))
}
null.out = replicate(10, rand.mpd.fun(pd.phylo))
obs.mpd = mpd(pd.sample, cophenetic(pd.phylo))
# SES=(obs-mean(rand))/sd(rand)
ses.all = (obs.mpd - apply(null.out, 1, mean))/apply(null.out, 1, sd)
# p-value =quantile.obs/(total.interation+1)
p.val.all = apply(cbind(obs.mpd, null.out), 1, rank)[1, ]/11
```


#### Constrained randomization

Type I error rates may be inflated using the above name shuffling null model if there is phylogenetic signal in abundance or occupancy of species. Hardy 20xx proposed to bin species based on their total abundance or site occupancy and make the null model more constrained. But the bining process is arbitrary and no set rules to follow...

In r, we can use `gseq()` in the `Rsundials` package to produce a geometric series, with minimum total abundance as starting value and maximum total abundance as ending value, and the exponent is the Hardy K.

```r
library(Rsundials)
hardy.k = 3
abun.bins = gseq(min(colSums(my.sample)), max(colSums(my.sample)), by = hardy.k)
# abun.bins: 3 9 27 81
assigned.bins = findInterval(colSums(my.sample), abun.bins)
# find the bin for each sp
names(assigned.bins) = names(my.sample)
split.bins = split(names(assigned.bins), assigned.bins)
# a list, each element is a sp list of one bin
shuffle.within.bins = unsplit(lapply(split.bins, sample), f = assigned.bins)
# reshuffle sp within the same bin and combine them back together.
tmp.sample = my.sample
colnames(tmp.sample) = shuffle.within.bins
# assign reshuffled names
pd(tmp.sample, my.phylo)
```

By doing this, we did one time reshuffling within bins and then calculated the phylogenetic diversity. Using `replicate()`, we can do this *n* times. We can also calculate the mpd using `mpd(tmp.sample, cophenetic(my.phylo))`. 

### Randomiza trait data

The randomization of functional trait data involve the shuffling of species names on the trait data matrix.

#### Unconstrained randomizations

One simple way is to simply shuffle the row names on the trait matrix (species by trait) using `sample(rownames(traits))` and then calculate community trait diversity. This maintains the observed patterns of trait co-variance and overall phenotypes.

#### Constrained randomizations

Community assembly usually was formed by environmental filtering at large scale and then by biotic interactions at small scale. As a result, species in the community may tend to have functional traits fall into some range. If the null model contains species with trait values far away from that range, the expectation from the null model may be biased (toward finding lower than expected mean nearest neighbor distances). As a result, sometimes to constrain species in the null model to those with trait values in the same range of observed species in the community may be preferred. However, this approach may reduce the number of random possibilities for a given dataset to a point at which there is no statistical power to reject the null hypothesis.


```r
# first find out the species pool with trait values fall into the same
# observed range for each community.  e.g. for community 1, tr.1.a: species
# whose trait < max obs trait for trait 1 at this comm.  tr.1.b: species
# whose trait > min obs trait for trait 1 at this comm.  etc.
pruned.names = Reduce(intersect, list(tr.1.a, tr.1.b, tr.2.a, tr.2.b, ...))
# species pool for community 1's null model
pruned.sample = my.sample[, pruned.names]
pruned.trait = traits[pruned.names, ]
# then shuffle the species names on the pruned trait matrix
rownames(pruned.trait) = sample(rownames(pruned.trait))
# mean nearest neighbor distance
mntd(pruned.sample, as.matrix(dist(pruned.matrix)), abundance.weighted = F)
```


### Null models for phylo and functional alpha diversity

```r
library(picante)
# phylogenetic diversity randomize community data matrix 999 times then
# calculate Faith's index ses and p-value
ses.pd(my.samlple, my.phylo, null.model = "indepedentswap", runs = 999, iterations = 1000)
# randomize the phylogeny instead of community data matrix
ses.pd(my.samlple, my.phylo, null.model = "taxa.labels", runs = 999, iterations = 1000)
# calculate mpd
ses.mpd(my.sample, cophenetic(my.phylo), null.model = "independentswap", ...)
ses.mpd(my.sample, cophenetic(my.phylo), null.model = "taxa.labels", ...)
# mnnd
ses.mnnd(my.sample, cophenetic(my.phylo), null.model = "independentswap", ...)
ses.mnnd(my.sample, cophenetic(my.phylo), null.model = "taxa.labels", ...)
```

For functional diversity, we can use `randomizeMatrix()` function and the `dbFD()` functionn to do one iteration. Then use `replicate()` to repeat and then calculate SES and use `rank()` to calculate p-value. If you computer has multiple CPU cores you can do parallel computation to speed up. One example code:

```r
library(parallel)  # not for Windows system
mclapply(1:1000, function(i, ...) {
    set.seed(i)
    FUNCTION_here
})
```


### Null models for phylo and functional beta diversity

Using name shuffling of the phylogeny is usually better than randomize community data matrix using independent swap, especially for phylogenetic and functional beta diversity analyses. It is recommended not to use independent swap null models for phylo and functional beta diversity since independent swap null model does not maintain the spatial structure of species in the system.


```r
# swap null models
comdist.is = function(x) {
    as.matrix(comdist(randomizeMatrix(x, null.model = "independentswap"), cophenetic(my.phylo), 
        abundance.weighted = F))
}
# name shuffling for pairwise
comdist.shuff = function(x) {
    as.matrix(comdist(my.sample, cophenetic(tipShuffle(x)), abundance.weighted = F))
}
# name shuffling for nearest neighbor dissmilarity
comdistnt.shuff = function(x) {
    as.matrix(comdist(my.sample, cophenetic(tipShuffle(x)), abundance.weighted = F, 
        exclude.conspecifics = F))
}

nulls = replicate(4, comdist.is(my.sample))
nulls.means = apply(nulls, c(1:2), mean)
nulls.sd = apply(nulls, c(1:2), sd)
obs = as.matrix(comdist(my.sample, cophenetic(my.phylo), abundance.weighted = F))
ses = (obs - nulls.means)/nulls.sd
# to get p-value
library(abind)
obs.nulls = abind(obs, nulls)
dim(obs.nulls)
array(dim = dim(obs.nulls), t(apply(apply(obs.nulls, c(1, 2), rank), 3, t)))[, 
    , 1]
```


