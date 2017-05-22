local({
  # input/output filenames are passed as command-line arguments
  a = commandArgs(TRUE)
  if (length(a) < 2) stop(
    "The script build_one.R requires at least 2 command-line args"
  )
  unlink(a[2])

  # a = c("content/en/2017-05-20-ms.Rmd", "content/en/2017-05-20-ms.md")
  # content/foo/bar/hi.Rmd -> foo/bar/hi
  d = knitr:::sans_ext(gsub('^content/', '', a[1]))
  to_add = sprintf("
```{r setup, include=FALSE}
knitr::opts_knit$set(
base.dir = normalizePath('../../static/', mustWork = TRUE),
base.url = '/', width = 60)
knitr::opts_chunk$set(
fig.path = 'figures/%s/',
cache.path = 'blogdown/cache/%s/',
error = FALSE, fig.width = 6, fig.height = 5, dpi = 96, tidy = TRUE)
```", d, d)
  content_rmd = blogdown:::readUTF8(a[1])
  x2 = blogdown:::split_yaml_body(content_rmd)

  if(any(grep(pattern = "bibliography:.*bib", x2$yaml)) ||
     any(grep(pattern = "\\\\@ref[(]", x2$body))) {# has citations or cross-references

    if(any(grep(pattern = "\\\\@ref[(]fig", x2$body))){ # to hold figures
      dir.create(sprintf('static/figures/%s/', d), recursive = T)
      # add knitr chunk
      new_rmd = append(content_rmd, to_add, x2$yaml_range[2])
    } else { # no figures
      new_rmd = content_rmd
    }
    new_rmd = append(new_rmd, "from_Rmd: yes", x2$yaml_range[2] - 1)
    new_rmd = append(new_rmd, "to_html: yes", x2$yaml_range[2])
    new_rmd_file = gsub("[.]md$", "2.Rmd", a[2])
    blogdown:::writeUTF8(new_rmd, new_rmd_file)
    blogdown:::render_page(new_rmd_file) # will produce a html file with the same name
    new_rmd_html = gsub("[.]Rmd$", ".html", new_rmd_file) # this is the name
    # add yaml back
    x3 = append(blogdown:::readUTF8(new_rmd_html),
                blogdown:::split_yaml_body(blogdown:::readUTF8(new_rmd_file))$yaml,
                0)
    unlink(c(new_rmd_file, new_rmd_html))
    blogdown:::writeUTF8(x3, a[3])
    Sys.chmod(a[3], '0444')  # read-only (should not edit)
  } else {# normal rmd files without citations or cross-referneces
    knitr::opts_chunk$set(
      fig.path   = sprintf('figures/%s/', d),
      cache.path = sprintf('blogdown/cache/%s/', d),
      error = FALSE, fig.width = 6, fig.height = 5, dpi = 96, tidy = TRUE
    )
    knitr::opts_knit$set(
      base.dir = normalizePath('static/', mustWork = TRUE),
      base.url = '/', width = 60
    )
    knitr::knit(a[1], a[2], quiet = TRUE, encoding = 'UTF-8', envir = .GlobalEnv)
    if (file.exists(a[2])) {
      x = blogdown:::append_yaml(
        blogdown:::readUTF8(a[2]), list(from_Rmd = TRUE)
      )
      blogdown:::writeUTF8(xaringan:::protect_math(x), a[2])
      Sys.chmod(a[2], '0444')  # read-only (should not edit)
    }
  }
})
