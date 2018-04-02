---
title: Updating website with Hugo and Blogdown
date: '2017-03-30'
slug: updating-website-with-hugo-and-blogdown
---

My personal website has been full of weeds since I did not update it for a really long time. As I am trying to put together a package to apply for jobs, I finally get some time to update my website. The previous version of my website was build with `Jekyll`. However, it is a bit slow and whenever I want to creat a new post, I need to type the yaml head. (Yes, you can set up a snippet, but...). Finally, [Yihui](https://yihui.name) wrote an awesome R package [blogdown](https://github.com/rstudio/blogdown) to creat personal website with `Hugo` and `Rstudio`, which makes it so much easier to update your website and to publish new blog posts. Here is a post to briefly record how I have done it. When it is not clear, the best way is to look at source code [here](https://github.com/rbind/yihui.name) or [here](https://github.com/daijiang/website_hugo_source).

## Install Hugo and create your site

First, go to the `blogdown` webpage and install it. For Mac users, you may need to install [homebrew](https://brew.sh) first, which you definitely should.

```r
devtools::install_github('rstudio/blogdown')
blogdown::new_site()
```

Then go to the new website folder, make it to be a git repository with `git init`. You should also make a `.gitignore` file.

Yihui's modified `hugo-lithium-theme` is simple and good, thus I decide to use it. You can install it with

```r
blogdown::install_theme('yihui/hugo-lithium-theme')
```

I did not install it this way, instead, I used 

```
git submodule add git@github.com:yihui/hugo-lithium-theme.git themes/hugo-lithium-theme
```

This will clone the theme into your themes folder locally but won't copy it when you push it into github (because of the `.gitmodules` file created).

## Tweak your website

Now you can put your old posts and webpages into the `content` folder. If you are familiar with CSS and html, then it should be straightforward. 

- `config.yaml` is the first file to change and it is self-explaining;
- logo picture should go into `static/images/logo.png`;
- CNAME file also into `static`, then Hugo will copy it into `public` folder, which is the generated website at the end;
  + anything within `static` folder will be copied to `public` as is: i.e. `static/images/fig1.jpg` will be copied as `public/images/fig1.jpg`.
- tweak files in `layout` folder, e.g. `partials/footer.html` to change footers of your website;
- if you want to close comments on some pages, put `disable_comments: true` in the yaml head.
- because my previous posts have slightly different syntax, I need to update them one by one using some [R code](https://github.com/daijiang/website_hugo_source/blob/master/R/clean_blogs.R).
- If you use Rstudio addins to creat a new post, set `options(blogdown.subdir = "content")` first, so then if you select subdirectory as `en` and title as `title`, then Rstudio will create the file as `content/en/date-title.md`, otherwise, it will create as `content/post/en/date-title.md`.
    + Now, you can just open Rstudio and start to write your blogs!


# Publish your website

## Approach 1: Push website into Github

Now, you need to create two repositories at Github: one to host the hugo folder and one to host the generated website (i.e. the `public` folder). Suppose you have two repositories now: `username.github.io` (to host generated website) and `website` (to host hugo code). Within your website folder:

```
rm -rf public # do not worry
git remote add origin https://github.com/username/website.git
git submodule add -f https://github.com/username/username.github.io.git public
# push website source code to github
git commit -am "Initial commit"
git push -u origin master
```

Now, you can generate the website again, either use Rstudio or terminal.

```
hugo
cd public
git add .
git commit -m "Build website"
git push -u origin master
```

## Approach 2: Use Netlify

The free plan of [netlify](www.netlify.com) can meet all my requirements: build my website from the source, https, and custom domain. So I have deployed my website there. The good thing is that I do not need to push the `public` folder to github anymore. Whenever I change the source code of my website, netlify will automatically rebuild my website for me! How cool it that?

## Issues

Here are some issues I still have:

- I used to have my Chinese and English blogs separated; and I have two short names for Disqus comments for them. Now I have merged these two blogs into one folder, but I cannot merge their comments too. I can only choose one shortname. Any solutions?
- ~~In this setup (submodule for `public` folder), whenever I rebuild the site, almost all webpages in the `public` folder changed and need to commit and push to github?? Why?~~
  + It turns out that Hugo will rebuild webpages that have been changed (e.g. lists of blog posts) but not all of them. So, this is not an issue anymore.
- to be updated.

## Useful links

- [Academia theme](https://georgecushen.com/create-your-website-with-hugo/)
- [publish website](https://nbari.com/post/hugo-hosting/)
