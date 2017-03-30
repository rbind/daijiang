---
title:  On Poisson process
date: '2014-01-24'
slug: on-poisson-process
---
> This is my study note for Math 605, UW-Madison. See more details at [here](http://www.math.wisc.edu/~anderson/605F13/605F13.html).

## Definitions
Almost every entry level statistical course introduce the Poisson distribution formula (we call this as the **first** formulation):
`\[f(k;\mu)=Pr(X=\mu)=\frac{\mu^{k}e^{-\mu}}{k!}\]`
where `\(X\)` is a discrete random variable,  `\(\mu\)` is the mean measure. When you need to calculate the probability of observing *k* events, you can just put *k* back to the formula. One important property of Poisson distribution is that its mean equals with its variance, i.e. `\(\mu=E(X)=Var(X)\)`.

Now let's consider continuous process. Suppose that we start at time 0 to count events (earthquakes, car accidents, number of death, etc.). For each time *t*, we obtain a number *N(t)*, which is the total number of events that has occurred up to time *t*. We then make the following modeling **assumptions** on the process *N(t)*:

1. For some `\(\lambda>0\)`, the probability of exactly one event occurring
in a given time interval of length *h* is equal to `\(\lambda h+o(h)\)`.
That is, for any `\(t\geq 0\)`, `\[P\{N(t+h)-N(t)=1\}=\lambda h+o(h),as\,h\rightarrow 0\]`
1. The probability that 2 or more events occur in an interval of length *h* is *o(h)*: `\[P\{N(t+h)-N(t)\geq 2\}=o(h),as\,h\rightarrow 0\]`
2. The random variables `\(N(t_{1}) - N(s_{1})\)` and `\(N(t_{2}) - N(s_{2})\)` are independent for any choice of `\( s_{1}\leq t_{1}\leq s_{2}\leq t_{2} \)`. This is usually termed an *independent interval* assumption.

We then sat that *N(t)* is a homogeneous Poisson process with *intensity, propensity*, or *rate* `\(\lambda\)`.

**Proposition 1**: Let *N(t)* be a Poisson process satisfying the three assumptions above. Then for any `\( t\geq s\geq0\)` and `\(k\in\{0,1,2,...\}\)`, we can prove that `\[P\{N(t)-N(s)\}=e^{-\lambda(t-s)}\frac{(\lambda(t-s))^{k}}{k!} \]` If we choose `\(s=0\)`, then we get `\[P\{N(t)-N(s)\}=e^{-(\lambda t)}\frac{(\lambda t)^{k}}{k!} \]`

Letting  `\(S_{1}\)` denote the time of the first increase in the process (i.e. the first event occurred), then according to Proposition 1, `\[ P\{S_{1}>t\}=P\{N(t)=0\}=e^{-\lambda t} \]` Therefore, the distribution of the first event time is *exponentially distributed* with a parameter of `\(\lambda\)`. Because of the independent increments assumption (assumption 3), we can see that the distribution of `\(S_{2}-S_{1}\)` is also *exponentially distributed* with a parameter of `\(\lambda\)`. Therefore, we see that ***N(t)* is simply the *counting process* of a renewal process with inter-event times determined by *exponential random variables***(we call this as the **second** formulation).

We now move to the **third** formulation of a one dimensional Poisson process. We say the *N* is a Poisson process with intensity `\(\lambda\)` if for any `\( A\subset\mathbb{R}_{\geq 0} \)` and `\( k\geq 0 \)`, we have that `\[P\{N(A)=k\}=e^{-\lambda|A|}\frac{(\lambda|A|)^{k}}{k!} \]` where `\(|A|\)` is the Lebesgue measure of A and if `\(N(A_{1}),...,N(A_{k}) \)` are independent random variables whenever `\(A_{1},...,A_{k} \)` are disjoint subsets of state space `\( E\)`. 

**Definition 1**. Let *N* be a point process with state space `\( E\in\mathbb{R}^{d}\)`, and let `\(\mu\)` be a measure on `\(\mathbb{R}^{d} \)`. We say that *N* is a Poisson process with mean measure `\(\mu \)`, or a Poisson random measure, if the following two conditions hold:

1. For `\(A\subset E \)`, `\[P\{N(A)=k\}=\begin{cases}
\frac{e^{-\mu(A)}(\mu(A))^{k}}{k!} & if\,\mu(A)<\infty\\
0 & if\,\mu(A)=\infty
\end{cases} \]`
2. If `\(A_{1},...,A_{k} \)`  are disjoint subsets of state space `\( E\)`, then `\(N(A_{1}),...,N(A_{k}) \)` are independent random variables.

**Note that the mean measure of a Poisson process, `\( \mu(A) \)`, completely determines the process**. One choice of the mean measure would be a multiple of Lebesgue measure, which gives length in `\( \mathbb{R}^{1}\)`, area in `\( \mathbb{R}^{2}\)`, volume in `\( \mathbb{R}^{3}\)`, etc. That is, if `\( \mu((a,b])=\lambda(b-a)\)`, for `\(a,b\in\mathbb{R}\)`, then `\(\mu\)` is said to be Lebesgue measure with rate, or intensity, `\(\lambda\)`. If `\(\lambda=1\)`, then the measure is said to be ***unit-rate***. For another example, a Poisson process with Lebesgue measure in `\(\mathbb{R}^{2}\)` satisfies `\(\mu(A)=Area(A) \)`. When the mean measure is a multiple of Lebesgue measure, we call the process ***homogeneous*** (`\(\lambda>1\)`).

If `\(\wedge\)` is a non-decreasing, absolutely continuous function, and over an open interval (a,b), then mean measure `\(\mu\)` for a Poisson process is `\[\mu((a,b))=\wedge(b)-\wedge(a)\]` If `\(\wedge\)` has density `\(\lambda\)` (i.e. it is differentiable), then `\[\mu((a,b))=\wedge(b)-\wedge(a)=\int_{a}^{b}\lambda(s)ds \]` As a result, for any `\( A\subset \mathbb{R}\)`, `\[P\{N(A)=k\}=e^{-\int_{a}^{b}\lambda(s)ds}\frac{(\int_{a}^{b}\lambda(s)ds)^{k}}{k!}\]`
 


**The three formulations above are all equivalent.**

>Some **definitions**: 
>>1. **Renewal process**: it is used to model occurrences of events happening at random time, where gaps between points (inter-event time) are i.i.d. random variables.
>>1. **Point process**: it is used to model a random distribution of points in space. It is a renewal process which distributes points so gaps are i.i.d. *exponential* random variables. e.g. locations of diseased deer in a given region (space); the breakdown times of certain part of a car (time). The simplest and most ubiquitous example of a point process is the Poisson point process.
>>1. **Lebesgue measure**: length, area, volume, etc. 

## Transformations of Poisson processes
+ If the position of the points of a homogeneous process of rate `\(\lambda>0\)` are multiplied by `\(\lambda\)`, then the resulting point process is also Poisson, and it is, in fact, a homogeneous process of rate 1. 
+ Likewise, we could start with a unit-rate process and divide the position of each point by `\(\lambda\)` to get a homogeneous process with rate `\(\lambda\)`. 
+ Also, move the points around via an one-to-one function, or transformation, resulted in another Poisson process.

## Simulating non-homogeneous Poisson process
Set `\(t_{0}=0,n=1 \)`.

1. Let `\(E_{n}\)` be an exponential random variable with parameter one, which is independent from all other random variables already generated.
2. Find the smallest `\( \mu\geq 0\)` for which `\[\int_{0}^{\mu}\lambda(s)ds=E_{1}+\cdots+E_{n}\]`
3. Set n+1 to n.
4. Return to step 1 or break.

###Example
Let N be a non-homogeneous Poisson process with local intensity `\(\lambda(t)=t^2\)`. Write a code that simulates this process until 500 jumps have taken place.

```r
library(ggplot2)
theme_set(theme_bw())
N=500 # number of jumps
time=vector() # to hold times of jumps
E_n=rexp(N) # N exp random values
for (i in 1:N){
  time[i]=(3*sum(E_n[1:i]))^(1/3)
}
ggplot(data=NULL)+geom_step(aes(x=c(0,time), y=c(0:500)))+
  geom_line(aes(x=c(0,time), y=c(0,time)^3/3), color="blue")
```


 

