---
title: R packages installation issues
date: '2017-04-29'
slug: r-packages-installation-issues
categories: []
tags: []
---

Some R packages that require installation from source are hard to install. Here, I just record some of the problems and solutions I have came acroos when installing R packages on macOS.

## `rgdal` package

It is kinda annoying to install this package. But I find [this answer](http://stackoverflow.com/a/26836125/3120725) to be helful for me to install it.

Basically, in terminal, install `GDAL` first, which will take a while:

```
brew install --with-postgresql gdal
```

Then in R:

```
install.packages('rgdal', type = "source", configure.args=c('--with-proj-include=/usr/local/include','--with-proj-lib=/usr/local/lib'))
```

## `sf` package

According to its github [readme file](https://github.com/edzer/sfr), we may be able to install binary package for `sf`. But this is not the case for me today. This may because that `R 3.4.0` just released and they did not prepare a binary version on CRAN yet. So, I still need to install from source. In its readme file, we need to do this in terminal first (takes a while, ~10 minutes):

```
brew unlink gdal
brew tap osgeo/osgeo4mac && brew tap --repair
brew install proj 
brew install geos 
brew install udunits
brew install gdal2 --with-armadillo --with-complete --with-libkml --with-unsupported
brew link --force gdal2
```

Then we can go to R and install it normally.

## to be updated
