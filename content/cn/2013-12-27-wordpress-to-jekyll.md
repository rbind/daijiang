---
title: 零基础从wordpress到jekyll
date: '2013-12-27'
slug: wordpress-to-jekyll
---
>状态更新：繁忙的又一个学期终于结束了。这个学期修了6个学分的课，同时把博士资格考试过了。修的课里面大部分还是学到了很多，除了多元统计的那么两个学分的seminar。假期终于有点空，于是从乡村旮沓里出来露个面。
>
>声明：这不是一篇教程，例如没有任何截图。这只是我的一点笔记。

圣诞节在家宅着，收到邮件说网站服务器马上要到期了。新的续费太贵了，加上最近总是看到用Jekyll搭建的博客都蛮好看的。于是觉得把博客从付费服务器撤下来，放到免费的github上。毕竟，我这基本没啥内容，用付费服务器纯属浪费。上网Google了下教程，基本都是如何用Jekyll搭建静态网站博客的，而且大多是(其实应该是全部)都要用命令行终端！我这被Windows毒害多年，又没有米买苹果的苦逼青年看着这命令行就头疼。但是没办法，硬着头皮上吧。不怕笑话，一个人在家也没人问，有问题Google，自己花了好一阵子才明白Windows底下如何用命令行，cd啥的。

First thing first. 这Jekyll究竟是干啥的？看了老半天终于明白这玩意就是编译你写的markdown文件成html，同时你可以用css文档来调整网站格式。Jekyll是用Ruby语言写的。于是跟着网上的教程一步步安装： Ruby, Gem, Jekyll， Jekyll-boostrap. 在windows下，ruby可以从[这里](http://rubyinstaller.org/downloads/)下载，同时可以在这里选择相对应的DevKit下载。下载好后，都解压到`C`盘: `C:\Ruby`; `C:\DevKit`。接下来的步骤可以参考[这里](http://blog.jsfor.com/skill/2013/09/07/jekyll-local-structures-notes/)。我遇到的几个问题都是通过这篇文章的方法解决的。之后花了好一阵子去看Jekyll的介绍和[Jekyllboostrap](http://jekyllbootstrap.com/)

接下来就是去[github pages](http://pages.github.com/)。他们有很好的帮助文档：如何建自己的网站，如何和自己的域名链接等。创建完网页之后才明白，**原来前面的Ruby, Jekyll等对于你的网站和博客的建立都不是必要的！！** 你在本地有安装那些的话你可以在把文件推送到github之前用`jekyll serve`提前看看。另一个好处就是遇到问题的话能够更清楚的知道是什么地方出问题了。如果本地没有安装这些的话，遇到问题你只会收到github发的邮件说不能建立你的网站，但是具体是什么问题在邮件里面没有。所以如果可以的话还是安装吧，但是**不是必需**。

弄好最基本的以后就是到处转转看看那些网站设计做的挺好，然后去他们的github整个端下来(厉害的话就自己设计了，可惜我什么都不懂)，读他们的`_layout`文件夹以及`CSS`和`_config.yml`。如果你跳过Ruby, jekyll安装的话，最好还是读一下jekyll的[介绍](http://jekyllbootstrap.com/lessons/jekyll-introduction.html)。然后读其他人的文档会比较容易懂。因为我没有任何的html和css的基础，花了我好一阵子才明白啥是啥。

最后就是把以前wordpress里面的文章导出来了。网上有教程但是在Windows底下纯粹就是折磨人。一会说`jekyll importer`有问题，大致是`cannot build native extended file`之类的。总之是怎么都解决不了。好在我文章不多，就手工小米加步枪一篇篇copy过来存在`md`文档里了。至于评论，因为刚开始就是用的[disqus](http://disqus.com/)，所以这个算是轻松的。但是要注意的是，同一篇文章，新旧网址要一致，要不然disqus就不能同步那篇文章的评论了。还有就是我发现文章标题还不能以数字开头，比如`2012`。要不然会出现错误（大致是）：

		undefined method 'gsub'... 

到这基本就差不多了。总结如下：

1. Ruby, Jekyll, Jekyll-bootstrap等不是必需。我就没有任何这方面的了解。但是读一下Jekyll的[介绍](http://jekyllbootstrap.com/lessons/jekyll-introduction.html)还是有必要的。中文Windows下安装我遇到的问题在[这里](http://blog.jsfor.com/skill/2013/09/07/jekyll-local-structures-notes/)都有相应的解决方法。
2. Git命令不了解也没有关系，可以用[Github for Windows](http://windows.github.com)。但是需要github的帐号，并建立一个项目并根据[github pages](http://pages.github.com/)的方法生成自己的用户网站并可以把自己的域名转接过去。如果没有自己的域名就用他们提供的就好，通常是`USERNAME.github.io`.
3. 生成好页面之后，看到好看的同样在github上搭建的网站，去他们的github项目库把整个项目库下载到自己的电脑，然后清空他们的`_posts`和其它他们自己的网页等，把自己的网页和文章放上去。当然你需要了解他们的`_layouts`,`CSS`. 比如把他们的网页Google analytical code换成自己的等。完成后，如果你本地有安装好`Jekyll`那就在本地用`jekyll serve`生成并调试。好了以后就推送到github。大约10秒左右你的网站就更新了。
4. 从[disqus](http://disqus.com/)转移评论时，文章标题不能以数字开头或纯数字，不然编译会有问题(至少我的情况是这样的， 不知道其他人的情况)。比如我在wordpress下有一篇文章题目是`2012`, 在新的md文档中就要改为如`年终-2012`。但是保存的md文档的名字可以是数字如`2013-01-01-2012.md`。这样这篇日志的网址就和以前一样，评论也就能转移过来。至于从wordpress自动导出文章(通过xml文档或数据库)，我都没有成功，略去不表。
5. 到这网站/博客基本就成型了，以后发表日志就只要新建一个`markdown.md`的文档，在开头放上， 如：

		---
		title: 从wordpress到jekyll
date: '2013-12-27'
slug: wordpress-to-jekyll
		---
然后就用[markdown 语法](http://wowubuntu.com/markdown/#p)专心写你的日志就好了。至于图片，我放在[flickr](http://flickr.com)上，然后把链接放在日志里。如果你有在本地安装Jekyll，那可以用命令来生成新的日志，就不用手动了。不过即使手动，也并不麻烦。写完保存名为：`2013-12-27-wordpress-to-jekyll.md`到`_posts`文件夹中。文件名会成为这篇日志的网址，所以不要有中文的好。然后推送到github就可以了。
1. 享受纯文本的清爽吧。不用再到处找wordpress插件和升级版本了。
2. 如果你有更好的方法，给我留言吧！谢谢！
