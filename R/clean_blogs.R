# library(blogdown)
# options(servr.daemon = TRUE)

# fix_context = function(x){
#   add_date = paste0("date: '", str_replace(i, "^.*/.*/([-0-9]{10})-.*md$", "\\1"), "'")
#   add_slug = paste0("slug: ", str_replace(i, "^.*/.*/[-0-9]{10}-(.*).md$", "\\1"))
#
#   # replace yaml
#   if(any(str_detect(x, "layout:"))) {
#     x = x[-which(str_detect(x, "layout:"))]
#   }
#   if(any(str_detect(x, "categories:"))) {
#     x[which(str_detect(x, "categories:"))] = add_date
#   }
#   if(any(str_detect(x, "tags:"))) {
#     x[which(str_detect(x, "tags:"))] = add_slug
#   }
#
#   # replace old highlight syntax
#   x = str_replace_all(string = x, pattern = "\\{% highlight r%\\}", replacement = "```r")
#   x = str_replace_all(string = x, pattern = "\\{% endhighlight %\\}", replacement = "```")
#   x
# }
#
# library(stringr)
#
# for(i in list.files("content/cn", full.names = T)){
#   x = readLines(i)
#   x_clean = fix_context(x)
#   writeLines(x_clean, i)
# }
#
# for(i in list.files("content/en", full.names = T)){
#   x = readLines(i)
#   x_clean = fix_context(x)
#   writeLines(x_clean, i)
# }
#
# for(i in list.files("content/zoey", full.names = T)){
#   x = readLines(i)
#   x_clean = fix_context(x)
#   writeLines(x_clean, i)
# }
