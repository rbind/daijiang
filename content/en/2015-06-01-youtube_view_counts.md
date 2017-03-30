---
title:  Youtube view counts of Linear Algebra lectures 
date: '2015-06-01'
slug: youtube_view_counts
---

I am learning linear algebra these days by watching the excellent series of lectures taught by Prof. Gilbert Strang at [Youtube](https://www.youtube.com/playlist?list=PLE7DDD91010BC51F8). During this journey, I think it would be interesting to look how many view count for all lectures. I expect the view counts will decline for later lectures.

Alright, first load some R packages in order to get data from Youtube.


```r
library(plyr)
library(dplyr)
library(rvest) # for webpage scripting
library(stringr) # string handling
library(ggplot2) # plotting
library(knitr)
```

Then I searched online to find out the url of the playlist for all lectures. To find the correct CSS part, I followed [this tutorial](http://cran.r-project.org/web/packages/rvest/vignettes/selectorgadget.html).


```r
# the playlist first
url = html("https://www.youtube.com/playlist?list=PLE7DDD91010BC51F8")
lectures = html_nodes(url, ".yt-uix-tile-link")
# length(lectures) # 35 vedio
# get lecture names
lec_names = html_text(lectures) %>% 
  sapply(function(x) str_replace(x, "^.*Lec ([b0-9]*) .*", "\\1")) %>% 
  unname() %>% as.character()
lec_names[lec_names == "24b"] = 24.5
lec_names = as.numeric(lec_names)
```

Then, get urls for all lectures and extract their view counts.


```r
# get url for all lectures
url_all = ldply(lectures, function(x){
  paste0("https://www.youtube.com", html_attr(x, name = "href"))
})

# for each lecture, get the view count
view_all = sapply(url_all$V1, function(x){
  print(x)
  xx = html(x)
  view_count = html_nodes(xx, ".watch-view-count") %>% html_text() %>%
    gsub(",", "", .) %>% 
    as.numeric()
  lect_descrip = html_nodes(xx, "#eow-description") %>% html_text() %>% 
    gsub("^(.*)View the complete.*$", "\\1", .) %>% str_trim()
  print(lect_descrip)
  list(view_count, as.character(lect_descrip))
})
```

Now, combine lecture names with their view counts.


```r
# combine lecture names with view count
view = unlist(view_all[(1:length(view_all)) %% 2 == 1])
# remove some notes that start with *.
descrip = unlist(view_all[(1:length(view_all)) %% 2 == 0])
descrip = sapply(descrip, function(x){
 if(str_detect(x, "\\*")){
   str_replace(x, "^(.*)\\*+.*$", "\\1")
 } else{
   x
 }
})
dat = data_frame(lec = lec_names, view = view, description = descrip)
kable(data.frame(lec = lec_names, view = format(view, big.mark = ","), description = descrip), format = "html")
```


<table>
 <thead>
  <tr>
   <th style="text-align:left;"> view </th>
   <th style="text-align:left;"> description </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 1,471,018 </td>
   <td style="text-align:left;"> Lecture 1: The Geometry of Linear Equations. </td>
  </tr>
  <tr>
   <td style="text-align:left;">   421,456 </td>
   <td style="text-align:left;"> Lecture 2: Elimination with Matrices. </td>
  </tr>
  <tr>
   <td style="text-align:left;">   359,628 </td>
   <td style="text-align:left;"> Lecture 3: Multiplication and Inverse Matrices. </td>
  </tr>
  <tr>
   <td style="text-align:left;">   304,766 </td>
   <td style="text-align:left;"> Lecture 4: Factorization into A = LU </td>
  </tr>
  <tr>
   <td style="text-align:left;">   210,564 </td>
   <td style="text-align:left;"> Lecture 5: Transposes, Permutations, Spaces R^n. </td>
  </tr>
  <tr>
   <td style="text-align:left;">   199,004 </td>
   <td style="text-align:left;"> Lecture 6: Column Space and Nullspace. </td>
  </tr>
  <tr>
   <td style="text-align:left;">   151,769 </td>
   <td style="text-align:left;"> Lecture 7: Solving Ax = 0: Pivot Variables, Special Solutions. </td>
  </tr>
  <tr>
   <td style="text-align:left;">   138,087 </td>
   <td style="text-align:left;"> Lecture 8: Solving Ax = b: Row Reduced Form R. </td>
  </tr>
  <tr>
   <td style="text-align:left;">   151,718 </td>
   <td style="text-align:left;"> Lecture 9: Independence, Basis, and Dimension. </td>
  </tr>
  <tr>
   <td style="text-align:left;">   132,971 </td>
   <td style="text-align:left;"> Lecture 10: The Four Fundamental Subspaces. </td>
  </tr>
  <tr>
   <td style="text-align:left;">   104,452 </td>
   <td style="text-align:left;"> Lecture 11: Matrix Spaces; Rank 1; Small World Graphs. </td>
  </tr>
  <tr>
   <td style="text-align:left;">    82,273 </td>
   <td style="text-align:left;"> Lecture 12: Graphs, Networks, Incidence Matrices. </td>
  </tr>
  <tr>
   <td style="text-align:left;">    77,250 </td>
   <td style="text-align:left;"> Lecture 13: Quiz 1 Review. </td>
  </tr>
  <tr>
   <td style="text-align:left;">   108,408 </td>
   <td style="text-align:left;"> Lecture 14: Orthogonal Vectors and Subspaces. </td>
  </tr>
  <tr>
   <td style="text-align:left;">    99,687 </td>
   <td style="text-align:left;"> Lecture 15: Projections onto Subspaces. </td>
  </tr>
  <tr>
   <td style="text-align:left;">    96,329 </td>
   <td style="text-align:left;"> Lecture 16: Projection Matrices and Least Squares. </td>
  </tr>
  <tr>
   <td style="text-align:left;">    95,593 </td>
   <td style="text-align:left;"> Lecture 17: Orthogonal Matrices and Gram-Schmidt. </td>
  </tr>
  <tr>
   <td style="text-align:left;">    90,094 </td>
   <td style="text-align:left;"> Lecture 18: Properties of Determinants. </td>
  </tr>
  <tr>
   <td style="text-align:left;">    79,339 </td>
   <td style="text-align:left;"> Lecture 19: Determinant Formulas and Cofactors. </td>
  </tr>
  <tr>
   <td style="text-align:left;">    85,189 </td>
   <td style="text-align:left;"> Lecture 20: Cramer's Rule, Inverse Matrix, and Volume. </td>
  </tr>
  <tr>
   <td style="text-align:left;">   159,954 </td>
   <td style="text-align:left;"> Lecture 21: Eigenvalues and Eigenvectors. </td>
  </tr>
  <tr>
   <td style="text-align:left;">   109,883 </td>
   <td style="text-align:left;"> Lecture 22: Diagonalization and Powers of A. </td>
  </tr>
  <tr>
   <td style="text-align:left;">    84,893 </td>
   <td style="text-align:left;"> Lecture 23: Differential Equations and exp(At). </td>
  </tr>
  <tr>
   <td style="text-align:left;">    84,173 </td>
   <td style="text-align:left;"> Lecture 24: Markov Matrices; Fourier Series.* </td>
  </tr>
  <tr>
   <td style="text-align:left;">    36,172 </td>
   <td style="text-align:left;"> Lecture 24b : Quiz 2 Review.* </td>
  </tr>
  <tr>
   <td style="text-align:left;">    59,755 </td>
   <td style="text-align:left;"> Lecture 25: Symmetric Matrices and Positive Definiteness.* </td>
  </tr>
  <tr>
   <td style="text-align:left;">    62,566 </td>
   <td style="text-align:left;"> Lecture 26: Complex Matrices; Fast Fourier Transform. </td>
  </tr>
  <tr>
   <td style="text-align:left;">    58,041 </td>
   <td style="text-align:left;"> Lecture 27: Positive Definite Matrices and Minima. </td>
  </tr>
  <tr>
   <td style="text-align:left;">    70,082 </td>
   <td style="text-align:left;"> Lecture 28: Similar Matrices and Jordan Form. </td>
  </tr>
  <tr>
   <td style="text-align:left;">    85,714 </td>
   <td style="text-align:left;"> Lecture 29: Singular Value Decomposition. </td>
  </tr>
  <tr>
   <td style="text-align:left;">    99,162 </td>
   <td style="text-align:left;"> Lecture 30: Linear Transformations and Their Matrices. </td>
  </tr>
  <tr>
   <td style="text-align:left;">    61,037 </td>
   <td style="text-align:left;"> Lecture 31: Change of Basis; Image Compression. </td>
  </tr>
  <tr>
   <td style="text-align:left;">    36,158 </td>
   <td style="text-align:left;"> Lecture 32: Quiz 3 Review. </td>
  </tr>
  <tr>
   <td style="text-align:left;">    55,596 </td>
   <td style="text-align:left;"> Lecture 33: Left and Right Inverses; Pseudoinverse. </td>
  </tr>
  <tr>
   <td style="text-align:left;">    50,540 </td>
   <td style="text-align:left;"> Lecture 34: Final Course Review. </td>
  </tr>
</tbody>
</table>

Finally, let's plot it.


```r
# plot
ggplot(dat, aes(x = lec, y = view)) +
  geom_point(color = "red", size = 2) + 
  geom_line(color = "blue") +
  labs(x = "Lectures", y = "Youtube view count",
       title = "Youtube view counts of Linear Algebra lectures taught by 
       Gilbert Strang, Srping 2005")
```

![Imgur](http://i.imgur.com/DtGk7Rt.png)

Wow, the first lecture has 1,471,030 by far (2015-06-21-23:00 Central Time)! However, the view count of the second lecture is about one million lower than the first one. It will be interesting to find out why lecture 21 and 22 have more view counts than their neighbors (I am getting their, at lecture 14 now! -- Eigenvalues!). The last lecture has about 50K views. Does this mean about 50K people finished all lectures? 

It clearly shows how hard it is to be persistent.


