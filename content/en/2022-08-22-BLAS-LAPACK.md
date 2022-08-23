---
title: Weird R issue caused by messed up BLAS/LAPACK libraries
date: '2022-08-22'
slug: blas-lapack
---

Today, the server had some really bizarre behavior: when run a simple linear regression using R multiple times, the results are totally different! How is this possible? There is no randomness in the linear regression, it is deterministic!!

I had no idea what is going on. Therefore, I posted in on [Stack Overflow](https://stackoverflow.com/questions/73451244/why-running-the-same-r-lm-code-gives-different-results/73452500#73452500). With some help from others, I though the issue may be from the [BLAS/LAPACK libraries](https://csantill.github.io/RPerformanceWBLAS/) on the server.

Currently, I have the Intel MLK version on the computer.

```
BLAS/LAPACK: /usr/lib/x86_64-linux-gnu/libmkl_rt.so
```

So, I changed it to the `OpenBLAS` library as it [has similar speed as MLK](https://csantill.github.io/RPerformanceWBLAS/).

```bash
sudo update-alternatives --config libblas.so.3-x86_64-linux-gnu
sudo update-alternatives --config liblapack.so.3-x86_64-linux-gnu
```

After restarting R, the problem is solved!! What a weird one.
