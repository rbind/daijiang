---
title: Latex test 
date: '2014-01-24'
slug: latex-test
---
Latex的设置是依据[这里](http://rangerway.com/way/2013/10/05/latex-note-and-jekyll/)。

1. 在我的cn文件夹中的`_layout`的`default.html`中添加MathJax library及其设置。
2. 在主文件夹(github.io)中相应的CSS文件中添加公式的CSS设置。
3. 在博客正文中需要写公式的地方把<code>\ [...\ ]</code>包含在acute符合(`)中来写行间公式，把<code>\ (...\ )</code>包含在其中来写行内公式。

#### The Lorentz Equations

`\[
\begin{aligned}
\dot{x} & = \sigma(y-x) \\
\dot{y} & = \rho x - y - xz \\
\dot{z} & = -\beta z + xy
\end{aligned}
\]`

How about inline formulas? `\(P(E)   = {n \choose k} p^k (1-p)^{ n-k} \)`
