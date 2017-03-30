---
title:  A simple R function to compress pictures
date: '2014-11-30'
slug: compress-pic-by-r
---
>I do not know too much about picture compression. There must be better ways/packages to do this. This small project is just for fun.

First, here is a function to blur a picture. It will use the mean value of all cells in a submatrix as value for each cell of that submatrix.

```r
library(png)
library(parallel)

filter.img = function(mat, k = 1) {
    pad.mat <- matrix(0, dim(mat)[1] + 2 * k, dim(mat)[2] + 2 * k)
    pad.mat[(k + 1):(dim(mat)[1] + k), (k + 1):(dim(mat)[2] + k)] = mat
    pad.mat2 = matrix(0, dim(pad.mat)[1], dim(pad.mat)[2])
    for (i in (k + 1):(dim(mat)[1] + k)) {
        for (j in (k + 1):(dim(mat)[2] + k)) {
            pad.mat2[i, j] = mean(pad.mat[(i - k):(i + k), (j - k):(j + k)])
        }
    }
    pad.mat2[(k + 1):(dim(pad.mat2)[1] - k), (k + 1):(dim(pad.mat2)[2] - k)]
}
```

Then let's read the picture below. Then we seperate the red, green, and blue arrays of the picture.
![v](http://i.imgur.com/HclZzde.png)

```r
# read picture and get red, green, blue arrays
str(vg <- readPNG("Van_Gogh_Wheatfield_with_Crows.png"))
red.vg <- vg[, , 1]
green.vg <- vg[, , 2]
blue.vg <- vg[, , 3]
filter.vg = list(red.vg, green.vg, blue.vg)
```

Then here is the function that will do the compression on each array and combine together.
```r
# blur red, gree, and blue and then combine together.
final.png = function(lst = filter.vg, k = 1) {
    out.filter.vg = mclapply(lst, function(x) filter.img(x, k = k), mc.cores = 3)
    out.array = array(unlist(out.filter.vg), dim = c(dim(lst[[1]])[1], dim(lst[[1]])[2], 
        3))
    writePNG(out.array, target = paste("dli55_", k, ".png", sep = ""))
}
```

Ok, let's try different extents of compression.

```r
final.png(k = 1)
```
![k1](http://i.imgur.com/poS9Cza.png)

```r
final.png(k = 3)
```
![k3](http://i.imgur.com/nvO5vwx.png)

```r
final.png(k = 5)
```
![k5](http://i.imgur.com/3Leq1uy.png)
