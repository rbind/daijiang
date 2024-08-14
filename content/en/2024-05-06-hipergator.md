---
title: Running R on HiperGator
date: '2024-05-06'
slug: hipergator-r
---

## The problem

How can I run R on HiperGator within my terminal? The interactive RStudio server works okay, but whenever you request a longer running time or more memory, you will wait much longer in queue. I would prefer to just run `R CMD BATCH` within my terminal.

## Solution

Update: just use `module load R`. No longer need to next steps.

It is probably documented somewhere by HiperGator. I just could not find it easily.

Here are the steps I followed.

1.  Login to HiperGator terminal, install [`miniforge`](https://github.com/conda-forge/miniforge) and `mamba`
2.  Exit terminal and login back again
3.  In terminal, run `mamba create -n nameofmyenvi r-essentials r-base`
    -   add additional packages you want to install, e..g, `r-torch`
    -   or install later with `mamba install cuda-toolkit=11.8 pytorch`
4.  `mamba activate nameofmyenvi`
5.  In terminal, type `R` and now you should be able to open R
    -   If running long time jobs, use `tmux` with `module load tmux`, then `tmux`
