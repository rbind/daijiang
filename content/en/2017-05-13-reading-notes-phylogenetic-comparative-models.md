---
title: 'Reading notes: phylogenetic comparative models'
date: '2017-05-13'
slug: reading-notes-phylogenetic-comparative-models
categories:
  - notes
---

> Brief notes for *my own use* from a short primer by [Cornwell & Nakagawa, 2017, Current Biology](http://www.cell.com/current-biology/fulltext/S0960-9822(17)30348-2). It is rather simple and basic, but can be a good intro/reminder about big pictures.

# Phylogenetic comparative methods

To explain the evolution of Earth's diversity, phylogenetic comparative methods (PCM) often combine phylogeny with traits of species. The building of phylogenies (phylogenetics) is different from PCMs though they are not independent. PCMs are used to address the questions: 

- how did the characteristics of organisms evolve through time?
- what factors influenced speciation and extinction?

Because species are not independent with each other, traditional linear regressions are not applicable. Felsenstein (1985), one of the first paper of PCMs, used phylogenetic independent contrasts to avoid this problem. Basically, instead of using species as data point, we can use the evolutionary branching point (divergence) as a replicate in the model.

## Trait evolution

We want to study the speed (tempo) and the manner (mode, e.g. slow and gradual, fast, with big jumps) of trait evolution. Common models are Briownian motion and Ornstein–Uhlenbeck models of trait evolution.

We also want to study evolutionary links among traits and between traits and environmental variables. Advanced methods include generalized linear mixed models and structural equation models that account for species evolutionary relationships.

## Lineage diversification

Why are some lineages more speciose than others of similar age? Where and when on the phylogeny were there shifts in diversification rate? And why did those shifts occur?

## PCMs in different disciplines

Other disciplines are also using PCMs, e.g. community ecology, linguistics, anthropology and paleobiology, by building phylogenies for e.g. languages.

## Caveats and the future of PCMs

- Tree uncertainty. Species can be misplaced in a phylogenetic tree, ancestral nodes can be wrongly inferred, or more subtly, but more commonly, branch lengths are incorrect.
- Trait uncertainty. Traits are measured with error. And for most PCMs, we used representative values, but it is hard to define representative. For example, what is the representative value for human height?
- Model uncertainty. When we investigate trait evolution, we assume a certain model of evolution — most often, the Brownian motion model. However, a trait can evolve quite differently from such a simple model and there may be heterogeneity in the tempo and mode among the branches of the tree.
