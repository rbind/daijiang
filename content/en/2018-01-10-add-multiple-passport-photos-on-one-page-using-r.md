---
title: Add Multiple Passport Photos on One Page using R
date: '2018-01-10'
slug: add-multiple-passport-photos-on-one-page-using-r
---

In this post, I document how to put multiple photos on one page to save paper.

First, after taking the photos, I edited them with [GIMP](https://www.gimp.org): adjust light, color, crop to the desired area. Then we need to [scale the cropped photo to the specified size](https://docs.gimp.org/en/gimp-image-scale.html). To do this, in the GIMP, I first selected `image/scale image`. This will allow us to scale the photo to the size required; it also allow us specify the resolution in different units (e.g. pixel/inch, pixel/mm). If you have photos for more than one kid, then make sure that both photos have the same size and resolution. This will make later steps easier. It would also be useful to check (and scale if necessary) the [print size](https://docs.gimp.org/en/gimp-image-print-size.html) too. After scaling the photo, [export](https://docs.gimp.org/en/gimp-export-dialog.html) it as an external file. Since I have two kids, I got two photos (same size and resolution) in my folder after these steps.

Time to use R. Specifically, the [`magick`](https://cran.r-project.org/web/packages/magick/index.html) package did all the heavy lifting.

First, read the photos into R.

```r
library(magick)
pic1 = image_read("pic1.jpg")
pic2 = image_read("pic2.jpg")
image_info(pic1) # size in pixel
image_info(pic2) # both should have the same size
```

To put multiple photos together, we can use the `magick::image_append()` function. This function, however, does not have an argument to specify the space between photos. Thus we need to create a blank image as a separator.

```r
sep = image_graph(width = 100, height = image_info(pic1)$height, 
                  bg = "white")
plot(1, type = "n", axes = F, xlab = "", ylab = "")
dev.off()
```

Great, now we are ready to put them together.

```r
pic1s = image_append(c(pic1, sep, pic1, sep, pic1, sep, pic1))
pic22 = image_append(c(pic2, sep, pic2, sep, pic2, sep, pic2))
# stack both
both = image_append(c(pic1s, pic2s), stack = TRUE)
```

Here I put four photos for each of them. You can adjust the above code if you want different numbers.

Finally, save the image to the disk.

```r
image_write(both, path = "both.jpg")
```

Check it out! We have multiple photos in one page now. One additional step (optional) is to open the new `both.jpg` in GIMP and [set the cavans size](https://docs.gimp.org/en/gimp-image-resize.html). I set it to 6 by 4 inches and exported it out.

That's it. Super simple but very useful.
