---
title:  Winners and losers replicated G-test
date: '2014-01-15'
slug: winners-and-losers
---

For long-term community dynamic studies, one question is which species are winners and which are losers after several decades. People use Indicator species analysis (ISA, Dufrene & Legendre 1997) or replicated G-teset (repG, Sokal & Rohlf 1995). For ISA, one can use the R package `labdsv` to do this. But there is no r function to do the repG.

Here, following Wiegmann & Waller (2006), I wrote a dirty R function for repG. The inputs are:

+ `dataframe`: a site * species dataframe, site as row, species as columns.  it includes both old date and new date. For example, 
the first 30 rows are data of 1958 in my study, the second 30 rows are data of 2012 since I have 30 sites for each time 
period.
+ `nsite`: how many sites do you have?
+ `old.quad`: how many quadrats per site in the old date? One reason for this is that not all resurveys used the same method as before.
+ `new.quad`: how many quadrats per site in the new date?

```r
repG = function(dataframe, nsite = 30, old.quad = 20, new.quad = 50) {
  rep.gtest = vector(mode = "list")
  library(plyr)
  for (i in 1:ncol(dataframe)) {
    df = data.frame(old = dataframe[, i][1:nsites], new = dataframe[, i][(nsites + 
                1):(nsites * 2)], old.quad = old.quad, new.quad = new.quad)
    df[(nsites + 1), ] = colSums(df)
    df$old.expected = rowSums(df[1:2]) * df$old.quad/(df$old.quad + df$new.quad)
    df$new.expected = rowSums(df[1:2]) * df$new.quad/(df$old.quad + df$new.quad)
    df$old.f = ifelse(df$old > 0, df$old * log(df$old/df$old.expected), 0)
    df$new.f = ifelse(df$new > 0, df$new * log(df$new/df$new.expected), 0)
    df$G = 2 * (df$old.f + df$new.f)
    df$df = 1
    df$p = pchisq(df$G, df$df, lower.tail = F)
    Gtotal = sum(df$G[-(nsites + 1)])
    dftotal = nsites
    ptotal = pchisq(Gtotal, dftotal, lower.tail = F)
    Ghete = Gtotal - df$G[(nsites + 1)]
    dfhete = dftotal - 1
    phete = pchisq(Ghete, dfhete, lower.tail = F)
    rep.gtest[[i]] = data.frame(sp = names(dataframe)[i], Gtotal = Gtotal, Ghete = Ghete, 
                                Gpool = df$G[(nsites + 1)], p.total = ptotal, p.hete = phete, 
                                p.pool = df$p[(nsites + 1)], old.freq = df$old[(nsites + 1)], 
                                new.freq = df$new[(nsites + 1)])                                                                                                   
  }
  rep.gtest = ldply(rep.gtest)
  rep.gtest$p.total = p.adjust(rep.gtest$p.total, "holm")
  rep.gtest$p.hete = p.adjust(rep.gtest$p.hete, "holm")
  rep.gtest$p.pool = p.adjust(rep.gtest$p.pool, "holm")
  winner.loser = rep.gtest[rep.gtest$p.total <= 0.05 & rep.gtest$p.pool <= 0.05, 
                           ]
  winner.loser$winloser = ifelse(winner.loser$old.freq - winner.loser$new.freq > 0, 
                                 winner.loser$winloser <- "loser", winner.loser$winloser <- "winner")
  winnerloser = arrange(winner.loser, winloser)
  return(winnerloser)
}
repG(dataframe)
```

> I just found that if the post tile has colon in it, Jekyll cannot parse it correctly! One solution (weired) is to use `&#58;` instead, then you can get the colon.
