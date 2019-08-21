---
title:  What is my name?
date: '2014-04-30'
slug: what-is-my-name
---
I know it is very hard for people do not speak Chinese to spell my name. Here is a list of what I was called in emails:

+ Daijaing: 46 threads of emails
+ Daijing: 30 threads of emails
+ Diajiang: 27 threads of emails
+ Daijian: 11 threads of emails
+ Dajiang: 3 thread of emails
+ Diajing: 2 threads of emails

Here is the plot:
![plot](https://i.imgur.com/h5GWmiW.png)

I did not include my correct name, which is *Daijiang* because all of emails with my name in the signature and I do not know how to filter it from the search...

```r
data = data.frame(name = c("Daijaing", "Daijing", "Diajiang","Daijian", "Dajiang", "Diajing"),
                  freq=c(46,30,27,11,3,2))
data$name = factor(data$name, levels = rev(c("Daijaing", "Daijing", "Diajiang","Daijian", "Dajiang", "Diajing")))
library(ggplot2)
ggplot(data=data, aes(x=name, y=freq))+geom_bar(stat="identity")+
  theme(axis.text=element_text(size=18, color="black"), axis.title=element_text(size=18),
        title=element_text(size=18))+
  labs(y="Frequency", x="Name", title="All of my 'names' from my Gmail inbox. Control: Daijiang")+coord_flip()
```
