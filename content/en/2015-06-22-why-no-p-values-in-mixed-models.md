---
title:  Why no p-values in mixed models 
date: '2015-06-22'
slug: why-no-p-values-in-mixed-models
---

For many traditional statistic modeling techniques such as linear models fitted by ordinary least squares (e.g. t-tests, ANOVA), we can derive exact distributions (e.g. t-distribution) for some statistics calculated from the data under null hypothesis; and then use these distributions to perform hypothesis tests on the parameters or calculate confidence intervals. It is tempting to believe that all statistical tech should provide a packaged results (e.g. p-values), but they do not. For example, you may have noted that summaries for model objects fitted with `lmer` list standard errors and t-statistics for the fixed effects, but no p-values. This is not without reason.

Early mixed-effects model methods used many approximations based on analogy to fixed effects ANOVA. For example, variance components were often estimated by calculating certain mean squares and equating the observed mean square to the corresponding expected mean square. In this way, we cannot handle multiple factors such as subjects and items associated with random effects as well as unbalanced data. Fortunately, it is now possible to evaluate the maximum likelihood or the REML estimates of the parameters in mixed-effects models (this is the case for R package `lme4`) to move further (e.g. handle unbalanced data, nested design, crossed random effects, etc.). However, the temptation to perform hypothesis tests using t-distribution or F-distributions based on certain approximation of the degrees of freedom in these distributions persists. 

An exact calculation may be possible for a comparatively simple model applied to exactly balanced data set. In real world, data often are unbalanced and models can be complicated. The distribution of the test statistic when the null hypothesis does not even have t-/F-distribution (or may not even know, [1][id1]). The formulas for the degrees of freedom for inferences based on t-/F-distributions do not apply in such cases (or even meaningless). In `lme4`, the numerators of the F-statistics are calculated as in a linear model. The denominator is the the penalized residual sum of squares divided by the REML degrees of freedom, which is n-p where n is the number of observations and p is the column rank of the model matrix for the fixed effects [(Douglas Bates)][id2]. All the F ratios use the **same denominator**. There are many approximations in use for hypothesis tests in mixed models, each leading to a different p-value, but none of them is "correct".

[id1]: https://stat.ethz.ch/pipermail/r-sig-mixed-models/2008q2/000904.html "r mail list"
[id2]: https://stat.ethz.ch/pipermail/r-help/2006-May/094765.html "explained by Douglas Bates"

Links 

- [Douglas Bates' explanation](https://stat.ethz.ch/pipermail/r-help/2006-May/094765.html)
- [Another explanation](https://stat.ethz.ch/pipermail/r-sig-mixed-models/2008q2/000904.html)
- [r-sig-mixed-model-FAQ](http://glmm.wikidot.com/faq)
