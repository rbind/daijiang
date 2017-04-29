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

## to be updated
