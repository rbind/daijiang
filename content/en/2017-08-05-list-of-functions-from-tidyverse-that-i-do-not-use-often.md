---
title: List of functions from tidyverse that I do not use often
date: '2017-08-05'
slug: func-tidyverse
---

I do not use these functions often, but they can be really useful for some tasks.

- `ggplot2` package:
  + `coord_cartesian(xlim = , ylim = )` to _zoom in_ a part of a figure, which is different from `xlim()` or `scale_x_continuous(limits = )`. The later will simply toss data points.
  + `cut_width()`, `cut_interval()`, `cut_number()` to convert a continous variable to groups.
  + ggplot by default will drop categories without any value, to avoid this, use `... + geom_bar() + scale_x_discrete(drop = FALSE)`.
  + reorder factor according to an numerical variable: `ggplot(data, aes(num_var, forcats::fct_reorder(factor_var, num_var))) + geom_point()`.
  + remove legend: `... + guides(fill = FALSE)` or `... + guides(color = FALSE)`
  + change legend rows: `... + guides(fill = guide_legend(nrow = 1))`
  + change legend title: `... + labs(fill = "title")` or `... + labs(color = "title")` or `... + scale_fill_xxx(name = "title")`
  + change axes tick labels: e.g. `... + scale_x_log10(labels = scales::dollar, labels = scales::wrap_format(10), breaks = ...)`. Package `scales` can be useful.
  + draw maps: `... + geom_polygon(aes(group = group)) + coord_map(projection = "albers", lat0 = 39, lat1 = 45)`
  + when write a function for plotting, `aes_string()` can be useful.
  + `scale_x_continuous(expand = c(.1, .1))` to expand the plot to avoid cutoff of labels.
  + `scale_x_discrete(limits = rev(level(grp)))` to reverse the order of a factor.
  + `p + xlab(NULL)` to remove x labels and its space.
- `tidyr` package:
  + `complete()` complete a data frame with missing combinations of data. Turns implicit missing values into explicit missing values.
  + `fill()` Fills missing values in using the previous entry. Useful if repeated values are omitted. Last observation carried forward.
  + `convert = TRUE` within `gather()` and `spread()` to convert the generated column into correct types.
  + `extract()` with regular expressions to extract part of a column.
- `dplyr` package
  + `transmute()` will only keep generated variables.
  + `count()` count the number of observations.
  + `left_join(x, y, by = c("a" = "b"))` when key variable has different names in x and y.
  + `bind_rows(list)` = `plyr::ldply(list)`: stack a list into a data frame (not always work, e.g. `bind_rows(list(1:2, 3:4))` does not work but `ldply()` works)
- `stringr` package
  + `str_subset(words, "x$")` = `words[str_detect(words, "x$")]`
  + `str_count()` will count how many matches resulted from `str_detect()`. `str_count("abababa", "aba")` will return 2.
  + When you use a pattern that’s a string, it’s automatically wrapped into a call to `regex()`. See more options for `regex()`.
- `forcats` package
  + `fct_reorder()`, `fct_reorder2()`
  + `fct_infreq()`, `fct_rev()`, `fct_recode()`, `fct_collapse()`, `fct_lump()`
- `purrr` package
  + `map(imput, fun)`, similar as `lapply()`; when input is a data frame, do something specified by `fun` to each column and return as a list. If want to return vector, use `map_dbl()`, `map_lgl()`, etc.
  + when input is a list, same as `plyr::l_ply()`; e.g. we can use `split(mtcars, mtcars$cyl)` to get a list from a data frame.
  +  `split(mtcars, mtcars$cyl) %>% map(~lm(mpg ~ wt, data = .))` do a lm to each element of the list; `~` is a shortcut for anonymous function, e.g. `split(mtcars, mtcars$cyl) %>% map( function(df) lm(mpg ~ wt, data = df))`
  + a list of models from the above point named as `models`, then `models %>% map(summary) %>% map_dbl(~.$r.squared)` will extract `$R^2$` of each model. We can do this by strings too: `models %>% map(summary) %>% map_dbl("r.squared")`; can even use position sometimes, e.g. ` map_dbl(list(list(1, 2, 3), list(4, 5, 6), list(7, 8, 9)), 2)`.
