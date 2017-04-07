---
title: "Writing Academic Papers with Rmarkdown"
slug: writing-academic-papers-with-rmarkdown
date: '2017-04-05'
---

> TL;DR: Rmarkdown and bookdown are awesome; you should use it to write papers; and [here](https://github.com/daijiang/workflow_demo) is a minimal example.

I have been using LaTex for most of the [papers](/resume) I have published so far (admittedly not that many), even though *all* of my co-authors use Microsoft Word. Why? Several reasons for this. 

1. When wrting, we should only focus on the content, not worrying about the typesetting, which we will take care later. Word, on the other hand, allows you to see what you get when you write. This makes people (me at least) hard to ignore the typesetting when writing. 
2. It is hard to update the figures and pictures inserted into the manuscript in Word. You need delete old ones and insert new ones whenever your figures are updated. Of course, you can say that do not insert figures until the submission. But wouldn't it be easier to revise the manuscript when figures are included in the main text? Using LaTex, I can just put the path of figures there and not worry about replace them in the main text.
3. [Literature programming:](https://en.wikipedia.org/wiki/Literate_programming) LaTex allows us to mix code with text in the same file, which increases the reproducibility and decreases potential errors.
4. Cross-references is easy in LaTex (just `\label` and `\ref`). With Word, it is painful to get the same thing.

However, LaTex has its learning curve and quirks. And even though it intends to make people to focus on content, we usually spend lots of time fighting with things like floats. Not to mention the collaboration barrier betwen its users to Word users. When I finished a draft of my paper, I need to convert it to Word using pandoc so my advisor can edit. Doing it this way, however, figures and tables are usually messed up, as well as cross-references. Tables will be just LaTex source codes there; cross-references will be replaced with their labels (e.g. see Table tab-labels instead of see Table 1). So everytime, I need to write something like "please do not care about the typesetting" in the email to my advisor.

Until recently, I found that the convertion from LaTex and Rmarkdown to Word is reasonably good, thanks to [`bookdown`](https://bookdown.org/yihui/bookdown/) by [Yihui](www.yihui.name). I just finished my first manuscript written in Rmarkdown 100%. Both my advisor and I are quite happy with it. Therefore, in this post, I am going to talk briefly the process of writing academic papers with Rmarkdown.

# Markdown and Rmarkdown

First, you need to know a little bit about the [syntax](https://www.rstudio.com/wp-content/uploads/2015/03/rmarkdown-reference.pdf). Don't worry, I am sure you will get it in five minutes. If you use Rstudio, this can be found under "Help" menu.

![rmarkdown references](http://i.imgur.com/U8RHPbm.png)

# Packages needed

In this post, I have installed the following R packages: `bookdown`, `rmarkdown`, `tufte`, and `knitr`. If you do not want to produce pdf files, then you are ready to go. If you need pdf files, then you need to install Latex. Under Windows and Linus, [Texlive](https://www.tug.org/texlive/) is good; under Mac, [Mactex](http://www.tug.org/mactex/) is available. If you do not mind the time to download and install, I recommend to install the full version, which includes all LaTex packages.

# Writing with Rmarkdown

After installing all dependencies, we can open Rstudio (or any text editor) and start writing. I use Rstudio to start the file and work with R code chucks. For the remaining, however, I use Sublime text or Atom. This is mainly because the lack of distraction free function in Rstudio.

## Yaml head

Here is the Yaml head I am using now:

```yaml
---
title: Your awesome tile
author: "Author one and Author Two"
date: '`r format(Sys.time(), "%d %B, %Y")`'
output:
  bookdown::tufte_html2:
    number_sections: no
    toc: yes
  bookdown::word_document2: null
  bookdown::pdf_document2:
    includes:
      before_body: doc_prefix.tex
      in_header: preamble.tex
    keep_tex: yes
    latex_engine: xelatex
    number_sections: no
    toc: no
bibliography: path/to/ref.bib
fontsize: 12pt
link-citations: yes
csl: https://raw.githubusercontent.com/citation-style-language/styles/master/global-ecology-and-biogeography.csl
---
```

A few notes here:

- I use the `bookdown::pdf_document2`, and other `bookdown::...document2`, which allow cross-references and other features possible.
- For pdf files, I included some tex files (`preamble.tex`, which includes some packages I use, e.g. lineno to add line numbers; and `doc_prefix.tex`, which allows text align at left only).
- References are put in the bib file. You can use common reference management software to create a bib file. Or you can search through Google Scholar and click on `cite` under the paper and choose `bibtex` form, then copy and paste the information into a bib file.
- `link-citations: yes` allows you click on a citation/table/figure and jumpo to the corresponding location.
- csl files are journal style files and can be a url like here or a local file.

## R chunks

In my [project set up](https://github.com/daijiang/workflow_demo), I have `.Rproj` file in the project folder, then I have `R`, `Doc`, etc. folders. R scripts are located within the `R` folder while the Rmarkdown file for the manuscript is in the `Doc` folder. By default, when you knit the Rmarkdown file with Rstudio, it will treat the folder where the Rmarkdown file seated as work space even though the `.Rproj` file is in the folder one level up. This is a little bit annoying because the path will be different if you click the `knit` button from running part of the chunks within Rstudio.

To let Rstudio know that we want use the parent folder as the work space, we can add this chunk at the beginning of the file:

    ```{r knitr_options, echo=FALSE}
    library(knitr)
    opts_knit$set(root.dir = normalizePath("../"))
    ```

Then in a *separate* R code chunk, we can use source R script with `source("R/script.r")`.

## Citations

After put the sources you want to cite in a `.bib` file, we can cite them in the main text. The idea is that each source will have one unique key, and you can cite it with the key. See the [rmarkdown website](http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html) for details and examples. 

```
Here is a statement [@key1; @key2].
@key3 did something.
Some examples [e.g. @key4; @key5; but see @key6]
```

![example of citaitons in markdown](http://i.imgur.com/EbKvlDr.png)

## Cross-references

### Tables

Insert tables by `knitr::kable` function (`::` tells that the `kable` function is from `knitr` package in R. Then cross-reference it back with: `see Table \@ref(tab:tableName)`, which will return something like `see Table 1`. The number of the table will depends on its order in the manuscript, therefore, whenever you reorder your tables, you do not need to worry about change their numbers by hand. And the R code chunk for the table looks like this:

    ```{r tableName1,results='asis', echo=F}
    knitr::kable(mtcars[1:5, 1:5], booktabs = T, caption = "Caption here.")
    ```

### Figures

Figures are very similar to cross-refer with tables. Basically, you use `Figure \@ref(fig:figName)` to refer to it. And you put the lable (`figName` here) and caption in the R code chunk:

    ```{r figName, fig.width=7, fig.asp=1, fig.cap="Your caption here."}
    plot(x, y)
    ```

See more examples in the [github file](https://github.com/daijiang/workflow_demo/blob/master/Doc/ms.Rmd).


These pretty much cover most of the common features of scientific writing: citations, cross-references, tables, figures. You can checkout [`bookdown`](https://bookdown.org/yihui/bookdown/) website for details. Even though `bookdown` is made for writing books, it is actually very good for writing papers too!

How do you set up Rmarkdown for writing? What tips do you have? Issues? Comments are very welcome. Or even better, you can click the `pen on paper` button at the top right of the post and edit it.
![edit this page](http://i.imgur.com/INZSdHa.png?1)

Thanks for reading and commenting!
