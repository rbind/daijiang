---
title:  Softwares I am using under Windows 7
date: '2014-01-03'
slug: software-I-am-using-under-win7
---
A few days earlier, I switched to another computer for better CPU and larger RAM. Both of them are run with Windows 7. Although I would love to learn Linux/Ubuntu, I don't have that time to learn it by trial and error. So I just stick with Windows. The following is a list of the softwares I am using. 

+ Microsoft office: well, I do not like them at all, but sadly, I need to use them.
+ Ctex:MikTex: for LaTex.
  + R(Knitr): `Maintainence (NOT Admin!)--MikTex setting--roots`, add: `C:\Program Files\R\share\texmf`.
  + Other sty files: Put `.sty` in `C:\CTEX\texmf\tex\latex\misc`; then open `MikTex-Maintainence(Admin)-Setting-Fresh FNDB`.

+ [Lyx](http://www.lyx.org/): a front end of LaTex
  * When I open a pdf file, I would like it to be automatic page fitted. So I usually will add `pdfstartview=FitH,citecolor=blue` in the Hyperlink option.
  * In order to put R code in the LaTex file, we need to connect Lyx with R. To do this, just in Lyx `tools -- pref -- path--prefix` add  `C:\Program Files\R\bin\i386`. Then when you create a new file, in Lyx `Document setting ---add module` choose and add `Rnw(knitr)`. Then you are done. In the file, when you need to use R code, simply put R codes between `<<>>=` and `@`.
  *  Citation. I use Zotero with Lyx for citations. 
     *  When you need cite references, in the position you want the reference section to be, `Insert--TOC--bib`, at the same time you can choose style file. Then back to the text, `insert--citations`.
     * If you want to use author-year style, you can go to `Document -- setting -- bibliography`: choose `natbib, author-year`.
     * If want multiple citations to be sorted, e.g. sometext(author et al, 2001; author 2000; author 2008) and you want sometext(author 2000; author et al 2001; author 2008), `document--setting--document class--class options--custom`: simple put `sort`. Do not do this in preambles.

+ [Zotero](https://www.zotero.org/): a nice open source reference manage software. The most attractive thing is that you can save references/webpages by one click. I use the standalone version and installed an add-on of Zotero in Google Chrome. So whenever I open an online journal paper, there will be an icon at the right end of the address frame. If I want to save that paper in my library, I can just click that icon and  I get everything (citation + auto-renamed pdf). Why not  Mendeley? Well, [here](http://timotheepoisot.fr/2013/01/19/elsevier-mendeley-out/) is one reason. Zotero provide 300Mb space for free. But it is too small for me. At this moment, I have 1Gb+ pdfs...One solution I have is to connect it with Dropbox.
	* Dropbox. If we put pdfs in Dropbox, we can get access to them whenever we have internet. 
	  * In Zotero, `Tools -- preferences -- Advanced -- Files and Folders` and change `Base directory` to say `E:\Dropbox\Zotero`; change `Data Directory` Location to the location you want, e.g. `E:\zotero`. Then copy all files from the file folder showed when you click the `Show Data Directory` to the new location.
	  * Then open a command line in Windows to create a symbolic links for directories. In the above example, Zotero will save pdfs in `E:\zotero\storage`, but we want them to be in Dropbox. So we use `mklink /D "E:\Zotero\storage"  "E:\Dropbox\Zotero\storage"` in the commend line. And we are all set! All pdfs will be in your Dropbox.
	* add-on: Lyz. In order to cite references in Lyx, one easy way is use Lyz in Zotero.
	  * In Zotero: `Tools --- add-ons --- extensions --- install add-on from files` (download Lyz.xpi first). Then in Lyz setting, set the Lyx server as `\\.\pipe\lyxpipe`.
	  * In Lyx: `tools --- preference --- paths --- Lyx server pipe` change to `\\.\pipe\lyxpipe`.
	  * In Lyx text, put the cursor at where you want to cite, go back to Zotero, click the `Lyz--cite in Lyx`. 

+ Evernote
+ Dropbox
+ 7-zip
+ Pandoc. Because others do not use Latex, and they need docx file, then use Pandoc to change file types. In this way, we can also take the advantages of hugh number of .csl files develpoed in Zotero. (you do not need to delete the .bst files in the tex file by hand.) 
	* > pandoc -s -S --biblio biblio.bib --csl ecology.csl in.text -o out.docx
* R. In windows, when you install R, delete the R version #. By doing this, you do not need to install libraries every time! i.e. Choose `C:\Program Files\R` instead of `C:\Program Files\R\R 3.0.1`.
* Rstudio
* Git
+ Chinese support `start -- control panel -- region and language -- Administrative -- change system locale -- Chinese simple`. 


