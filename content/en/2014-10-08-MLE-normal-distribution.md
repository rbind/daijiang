---
title:  Maximum likelihood estimation of normal distribution
date: '2014-10-08'
slug: MLE-normal-distribution
---

The probability density function of normal distribution is:
`\[
f(x)=\frac{1}{\sigma\sqrt{2\pi}}e^{-\frac{(x-\mu)^{2}}{2\sigma^{2}}}
\]`


Support we have the following *n i.i.d* observations: `\(x_{1},x_{2},\dots,x_{n}\)`.
Because they are independent, the probability that we have observed
these data are:
`\[
f(x_{1},x_{2},\dots,x_{n}|\sigma,\mu)=\prod_{i=1}^{n}\frac{1}{\sigma\sqrt{2\pi}}e^{-\frac{(x_{i}-\mu)^{2}}{2\sigma^{2}}}=(\frac{1}{\sigma\sqrt{2\pi}})^{n}e^{-\frac{1}{2\sigma^{2}}\sum_{i=1}^{n}(x_{i}-\mu)^{2}}
\]`


`\[\begin{array}{cl}
\log(f(x_{1},x_{2},\dots,x_{n}|\sigma,\mu)) & =\log((\frac{1}{\sigma\sqrt{2\pi}})^{n}e^{-\frac{1}{2\sigma^{2}}\sum_{i=1}^{n}(x_{i}-\mu)^{2}})\\
 & =n\log\frac{1}{\sigma\sqrt{2\pi}}-\frac{1}{2\sigma^{2}}\sum_{i=1}^{n}(x_{i}-\mu)^{2}\\
 & =-\frac{n}{2}\log(2\pi)-n\log\sigma-\frac{1}{2\sigma^{2}}\sum_{i=1}^{n}(x_{i}-\mu)^{2}
\end{array}\]`

Let's call `\(\log(f(x_{1},x_{2},\dots,x_{n}|\sigma,\mu))\)` as `\(\mathcal{L},\)`
then let:
`\[
\frac{d\mathcal{L}}{d\mu}=-\frac{1}{2\sigma^{2}}\sum_{i=1}^{n}(x_{i}-\mu)^{2}\mid_{\mu}=0
\]`
 solve this equation, we get 
`\[
\frac{1}{2\sigma^{2}}\sum_{i=1}^{n}(2\hat{\mu}-2x_{i})=0
\]`

Because `\(\sigma^{2}\)` should be larger than zero,
`\[
\hat{\mu}=\frac{\sum_{i=1}^{n}x_{i}}{n}
\]`


Similarly, let
`\[
\frac{d\mathcal{L}}{d\sigma}=-\frac{n}{\sigma}+\sum_{i=1}^{n}(x_{i}-\mu)^{2}\sigma^{-3}=0
\]`


I realized that it would be better to get the maximum likelihood estimator
of `\(\sigma^{2}\)` instead of `\(\sigma\)`. Thus

`\[
\hat{\sigma}^{2}=\frac{\sum_{i=1}^{n}(x_{i}-\hat{\mu})^{2}}{n}
\]`


But this MLE of `\(\sigma^{2}\)` is biased. A point estimateor `\(\hat{\theta}\)` is said to be an unbiased estimator
of `\(\theta\)` is `\(E(\hat{\theta})=\theta\)` for every possible value
of `\(\theta\)`. If `\(\hat{\theta}\)` is not unbiased, the difference `\(E(\hat{\theta})-\theta\)`is
called the bias of `\(\hat{\theta}\)`.

We know that 
`\[
\sigma^{2}=Var(X)=E(X^{2})-(E(X))^{2}\Rightarrow E(X^{2})=Var(X)+(E(X))^{2}
\]`

Then
`\[
\begin{array}{cl}
E(\hat{\sigma}^{2}) & =\frac{1}{n}E(\sum_{i=1}^{n}(x_{i}-\hat{\mu})^{2})\\
 & =\frac{1}{n}E(\sum x_{i}^{2}-n\hat{\mu}^{2})\\
 & =\frac{1}{n}E(\sum x_{i}^{2}-\frac{(\sum x_{i})^{2}}{n})\\
 & =\frac{1}{n}\left\{ \sum E(x_{i}^{2})-\frac{1}{n}E\left[(\sum x_{i})^{2}\right]\right\} \\
 & =\frac{1}{n}\left\{ \sum(\sigma^{2}+\mu^{2})-\frac{1}{n}\left[n\sigma^{2}+(n\mu)^{2}\right]\right\} \\
 & =\frac{1}{n}\left\{ n\sigma^{2}+n\mu^{2}-\sigma^{2}-n\mu^{2}\right\} \\
 & =\frac{n-1}{n}\sigma^{2}\\
 & \neq\sigma^{2}
\end{array}
\]`


Bias is `\(E(\sigma^{2})-\sigma^{2}=-\frac{\sigma^{2}}{n}\)`. In fact the unbiased estimator of
`\(\sigma^{2}\)` is `\(s^{2}=\frac{\sum_{i=1}^{n}(x_{i}-\hat{\mu})^{2}}{n-1}\)`.
But the fact that `\(s^{2}\)` is unbiased does not imply that `\(s\)` is
unbiased for estimating `\(\sigma\)`. The expected value of the square
root is not the square root of the expected value. Fortunately, the
biase of `\(s\)` is small unless the sample size is very small. Thus
there are good reasons to use `\(s\)` as an estimator of `\(\sigma\)`.
