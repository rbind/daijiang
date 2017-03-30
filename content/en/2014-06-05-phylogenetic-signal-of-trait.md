---
title:  Phylogenetic signal of functional trait
date: '2014-06-05'
slug: phylogenetic-signal-of-trait
---
>This is my reading notes for *Functional and Phylogenetic Ecology in R* by Nathan Swenson.
This post will be updated later after I learned more about this topic.
Data can be found at [here](http://link.springer.com/chapter/10.1007%2F978-1-4614-9542-0_7)

## Phylogenetic signal

Niche Conservatism: Closely related species are found to be ecologically similar.

Phylogenetic niche conservatism: Closely related species are found to be ecologically similar; the tendency of lineages to retain their niche-related traits through speciation events and over macroevolutionary time.

Because all species are related they cannot be treated as independent observations. As a result, the assumption of independence is broken for traditional statistical analysis.

### Trait correlations

#### Independent contrasts

The phylogenetic independent contrasts (PICs) method is one of the most common approch for quantifying the correlations between two traits while considering the phylogenetic nonindependence of species. For each internal node in the phylogeny, a contrast will be calculated for a trait. A contrast is the difference in a trait between the two daughter nodes weighted by their branch lengths. The estimated trait value for an node is calculated as the mean of its daughter nodes weighted by their branch lengths. As a result, contrasts can be calculated from the tips of the phylogeny toward the root. If the traits are correlated after accounting for phylogenetic nonindependence, it is expected that the contrast values themselves, which are now statistically independent, are correlated. The PICs can be calculated with `pic()` function in the `ape` package.


```r
traits = read.table("data/comparative.traits.txt", sep = "\t", header = T, row.names = 1)
library(ape)
my.phylo = read.tree("data/comparative.phylo.txt")
# calculate contrasts for each node (11-19) for trait 1
(pic.x = pic(traits[my.phylo$tip.label, 1], my.phylo))
```

```
##      11      12      13      14      15      16      17      18      19
## -1.0614  0.7670  0.1739 -1.1430 -0.6850  0.4511  0.7431 -1.0035  0.3361
```

```r
(pic.y = pic(traits[my.phylo$tip.label, 3], my.phylo))
```

```
##      11      12      13      14      15      16      17      18      19
## -0.3116  0.1698  0.3117 -0.2539 -0.1701 -5.0199 11.3501 -4.0144  0.1614
```

```r
summary(lm(pic.y ~ pic.x - 1))
```

```
##
## Call:
## lm(formula = pic.y ~ pic.x - 1)
##
## Residuals:
##    Min     1Q Median     3Q    Max
## -5.954 -1.418 -0.048  1.886  9.811
##
## Coefficients:
##       Estimate Std. Error t value Pr(>|t|)
## pic.x     2.07       1.85    1.12     0.29
##
## Residual standard error: 4.29 on 8 degrees of freedom
## Multiple R-squared:  0.136,	Adjusted R-squared:  0.0277
## F-statistic: 1.26 on 1 and 8 DF,  p-value: 0.295
```

```r
# plot(pic.y~pic.x) abline(lm(pic.y~pic.x-1))
```

#### Phylogenetic generalized least squares

A more general method for quantifying the correlation of two trait is to perform a phylogenetically informed regression. Phylogenetic generalized least squares (PGLS) regression is one of the most common one. PGLS incorporates phylogenetic nonindependence into generalized linear models in the form of a phylogenetic variance-covariance (VCV) matrix. The regression model uses an assumed model of trait evolution to generate an expected correlation structure (i.e., nonindependence) in the data. One most common assumed model of trait evolution is the Brownian Motion model, which can be applied using the `corBrownian()` function in the `ape` package.


```r
cor.bm = corBrownian(phy = my.phylo)
trait.1 = traits[my.phylo$tip.label, 1]
trait.3 = traits[my.phylo$tip.label, 3]
library(nlme)
pgls = gls(trait.3 ~ trait.1, correlation = cor.bm)
summary(pgls)
```

#### Phylogenetic eigenvector regression
The above two methods have a model of trait evolution. An alternative method that uses Euclidean distances from the phylogeny in the form of a phylogenetic distance matrix and assummes no model of trait evolution, which makes it controversial, is called phylogenetic eigenvector regression. It uses the same general class of eigenvector-based statistics designed to account for spatial autocorrelation in data with the exception that the goal now is to account for phylogenetic autocorrelation. The distance matrix is used in a principle components analysis to derive spatial or phylogenetic eigenvectors. The scores from the PCA, as well as one trait, will be independent variables, the other trait will be the dependent variable in the regression. How many axes from PCA to include as independent variables in the model? We can plot the axes of the PCA then decide.

Distance matrix --- PCA --- trait2 ~ score1 + score2 + ... + trait1


```r
p.dist.mat = cophenetic(my.phylo)
phylo.pca = princomp(p.dist.mat)
summary(phylo.pca)
# to visualize the load with the tree
library(adephylo)
library(phylobase)
obj4d = phylo4d(my.phylo, phylo.pca$scores[, 1:2])
table.phylo4d(obj4d)
# fit the model
pev.mod = lm(trait.3 ~ trait.1 + phylo.pca$scores[, 1] + phylo.pca$scores[,
    2])
summary(pev.mod)
```

Since the statistical power of phylogenetic eigenvector regression is low, also it does not assume a model of trait evolution, most comparative methods researchers and biologists usually **DO NOT** use this method.

### Quantifying phylogenetic signal
Regard phylogenetic signal as the degree to which variation in species trait values is predicted by the relatedness of species.

#### Mantel test
Mantel test quantifies the correlation between two distance matrices. Here, these two distance matrices are the phylogenetic distance matrix and a univariate or multivariate trait distance matrix. Despite its easy to understand, this method is now *infrequently* used since its lower statistical power and higher type I error rates compare with other new metrics. We can use the `mantel()` function from the `vegan` package to do this.

#### Blomberg's K and significance tests
This method seeks to quantify the degree to which variation in a trait is explained by the structure of a given phylogeny. This value is then standardized by an expectation derived from Brownian motion trait evolution on the observed phylogeny. Since the statistics, K, is standardized, it allows for the comparison among other studies.


```r
n = length(trait.1)  # trait.1 is X parameter in Blomberg et al. n is parameter n.
my.vcv = vcv.phylo(my.phylo)  # parameter V
inverse.vcv = solve(my.vcv)  # parameter V^-1
root.value = sum(inverse.vcv %*% trait.1)/sum(inverse.vcv)  # parameter a hat
# phylogenetic corrected trait mean
MSEo = (t(trait.1 - root.value) %*% (trait.1 - root.value))/(n - 1)
# the mean squared error of the trait
MSE = (t(trait.1 - root.value) %*% inverse.vcv %*% (trait.1 - root.value))/(n -
    1)
# the mean squared error of the trait given the VCV
ratio.obs = MSEo/MSE  # observed ratio of mean squared errors
ratio.expected = (sum(diag(my.vcv)) - (n/sum(inverse.vcv)))/(n - 1)
k = ratio.obs/ratio.expected  # standardized and can be compared across studies
```
*If K = 1, then it indicates that the observed variation in the trait is predicted by the structure of the phylogeny under a Brownian motion model of trait evolution. If K > 1, it suggests more phylogenetic signal than expected from Brownian motion. If K < 1, it suggests less phylogenetic signal than expected from Brownian motion.*

Of course, there are R packages already that we can use to calculate K instead of hard code by hand. The null hypothesis will be: K = null expectation.

```r
library(phytools)
phylosig(tree = my.phylo, x = trait.1, method = "K", test = T)
```

#### Pagel's Lambda
This method seeks the transformation of the original phylogeny that best predicts the distribution of our traits on the phylogeny under a Brownian Motion model of trait evolution. The phylogeny is transformed using a parameter called lambda (lambda's range: 0 to ~1: one retains the original tree, zero will produce a star tree where all spcies are equally related, i.e. a single polytomy). We can use `transform()` function of the `geiger` package to transform a tree.

With the decreasing of lambda from one to zero, *internal nodels are pushed toward the root*. As a result, the most recent common ancestor (MRCA) will be far away and trait variation is expected to be larger under Brownian motion model.

The general idea of this method is to search for the lambda value that transforms the original phylogeny such that the observed distribution of traits on the tips of the phylogeny is mirrored by that expected under Brownian motion on the transformed phylogeny. *A low lambda indicates very little phylogenetic signal in the trait data given the original tree and a high lambda indicates relatively more phylogenetic signal in the trait data given the original tree.*  

The null hypothesis is: lambda = 0.

```r
phylosig(tree = my.phylo, x = trait.1, method = "lambda", test = T)
```
#### Standardized contrast variance, unstandardized contrast means and randomization test
Recall that contrast for a node describes the magnitude of the difference of the trait values for daughter nodes. This difference can be standardized weighting by branch lengths or unstandardized where all btanch lengths are set to one. Thus large contrast values indicate that daughters are very divergent in trait aand lack of phylogenetic signal. The mean contrast value has been used in the past to quantify phylogenetic signal.


```r
my.phylo.2 = my.phylo
# set all branch length to 1, and calculate unstandardized contrast.
my.phylo.2 = compute.brlen(my.phylo.2, method = 1)
mean(pic(trait.1, my.phylo.2))  # mean of unstandardized contrast of nodes
# after then, we can reshuffle the tips of the tree and get a null
# distribution of mean of pic() then we can test the significance of the
# value observed .
```

Another way is to use the variance of the standardized contrasts to quantify phylogenetic signal. The smaller the variation, the more similar of colsely related species.

```r
var(pic(trait.1, my.plyo))  # use the branch length
# again, we can reshuffle th tips n times to get the null distribtuion and
# to get the p-value.
```
These two methods are not used as commom as the K and lambda methods.

### Quantifying the timing and magnitude of trait divergences
The phylogenetic signal we detected above are phylogeny-wide. However, we are often interested node-level signal or antisignal and how this signal changes with the position of the node in the phylogeny, i.e. whether large/small divergences tend to be correlated with the depth in the phylogeny.

We can calculate the `pic` of each node, then using randomization to get the null distribution of each node then we can get the rank of the observed value for each node and plot the rank on the tree (`nodelabels(ranking)`).

Check `dtt()` function of `geiger` package for more details.
