---
title:  Zoe or Zoey
description: 很早就决定给女儿取英文名了。最后觉得Zoey还不错。但是应该用哪一个拼写呢？
date: '2014-08-31'
slug: zoe-or-zoey
---

很早就决定给女儿取英文名了。最后觉得Zoey还不错。但是应该用哪一个拼写呢？

先看看这两个名字过去一百年的趋势吧！数据来源于美国社保局 (USA social security administration)。这个数据库包含了从1880年到2013年每年至少有5个人用了的所有名字及其应用次数。

>For each year from 1880 to 2013, the number of children of each sex given each name. All names with more than 5 uses are given. (Source: http://www.ssa.gov/oact/babynames/limits.html)

兵马未动，代码先行。

```r
library(babynames)
library(plyr)
library(dplyr)
library(ggplot2)
data(names)
babynames = tbl_df(babynames)
filter(babynames, name == "Zoe") -> zoe
filter(babynames, name == "Zoey") -> zoey
babynames %>%
  filter(name=="Zoey" | name == "Zoe") %>%
  ggplot()+geom_line(aes(x=year, y=prop, color = name), size = 2)+facet_wrap(~sex)
```

![zoey](https://i.imgur.com/V1I4sGX.png)

```r
babynames %>%
  filter(name=="Zoey" | name == "Zoe" | name == "Olivia" | name == "Elisha" 
         | name == "Linsey" | name == "Lindsey" | name == "Ella") %>%
  ggplot()+geom_line(aes(x=year, y=n, color = name, linetype = name), size = 2)+facet_wrap(~sex)
```

![other](https://i.imgur.com/qt8618s.png)

Zoe这个名字从1880年就有人用了，而Zoey到了1970才每年有超过5个人用。这两个名字从1990年以后就都变得流行起来。而2000年以后，Zoey比Zoe更流行了。

让我意外的是，居然也有男孩取名Zoe或Zoey！尽管数量很少。这也不难理解，毕竟每年出生人口这么多。

看起来Zoey Li是个更好的名字，从趋势上来说。而且，Zoey Li比Zoe Li看起来更好看。因为前者占了三行（三线格）。
