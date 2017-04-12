---
title: Clipping shape files in R
date: '2017-04-12'
slug: clipping-shape-files-in-r
---

Suppose we have two shape files: one larger (e.g. shapefile of ecoregions of North American) and one smaller (e.g. shapefile of US lower states). How can we get the shapefile of ecoregions for only the US lower states? 

After a little bit searching ^[mainly this post: https://philmikejones.wordpress.com/2015/09/01/clipping-polygons-in-r/], I came with the following R function:

```r
library(rgeos)
library(sp)
clip_shp = function(small_shp, large_shp){
   # make sure both have the same proj
  large_shp = spTransform(large_shp, CRSobj = CRS(proj4string(small_shp)))
  cat("About to get the intersections, will take a while...", "\n")
  clipped_shp = rgeos::gIntersection(small_shp, large_shp, byid = T, drop_lower_td = T)
  cat("Intersection done", "\n")
  x = as.character(row.names(clipped_shp))
  # these are the data to keep, can be duplicated
  keep = gsub(pattern = "^[0-9]{1,2} (.*)$", replacement = "\\1", x)
  large_shp_data = as.data.frame(large_shp@data[keep,])
  row.names(clipped_shp) = row.names(large_shp_data)
  clipped_shp = spChFIDs(clipped_shp, row.names(large_shp_data))
  # combine and make SpatialPolygonsDataFrame back
  clipped_shp = SpatialPolygonsDataFrame(clipped_shp, large_shp_data)
  clipped_shp
}
```

By running `clip_shp()` function, we will return a shapefile of the intersections between the two input files ^[Of course, you need to read them first into R. E.g. `small_shp = rgdal::readOGR("path/to/file), layer = "file_name`].


Another problem is that such kind of shapefiles are too large to plot. `ggplot()` may run forever with the data frame fortified from the shapefile. One solution is to first convert the shapefile into a data frame, then thin the data frame. Simply using `dplyr::sample_frac()` won't work though. Here is a function I wrote (though kind of slow):

```r
# the larger the tol is, the less rows the result will have
thin = function(x, tol = 0.01){
  id = unique(x$id)[1]
  x1 = x[, 1:2]
  names(x1) = c("x", "y")
  x2 <-shapefiles::dp(x1, tol)
  data.frame(long = x2$x, lat = x2$y, id = id)
}

library(ggplot2)
library(dplyr)
# convert shapefile to data frame
shp_df = fortify(shp, region = "NAME") # change the region accordingly
# for each group, thin it
shp_df_thin = select(shp_df, long, lat, id, group) %>%
  group_by(group) %>%
  do(thin(., tol = 0.02))
```

Then we can use the thinned data frame to happily/fastly plot with `ggplot()`.

```r
ggplot(data = shp_df_thin) + 
  geom_polygon(aes(x = long, y = lat, group = group), 
               color = "black", fill = "white") +
  coord_map() 
```

Post here in case it will be helpful (to someone else or future myself).
