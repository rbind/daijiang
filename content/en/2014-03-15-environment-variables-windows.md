---
title:  Environment Variables under Windows
date: '2014-03-15'
slug: environment-variables-windows
---

My six years old laptop shows its age more and more often this semester. Today, I reinstalled the operation system (Windows 7), with the hope that it will improve the speed a little bit. Needless to say, it is a really paiful task. I think I did not format the operation system disk for about three years now. During these three years, I installed a lot of softwares and I need to reinstall most of them by hand!

## List of softwares
Here is the list of the softwares I installed today:

#### Research relevant:
- [R](http://www.r-project.org/): statistical software
- [RStudio](http://www.rstudio.com/): IDE of R
- [Github for Windows](http://windows.github.com/): 
- [Dropbox](https://www.dropbox.com/): sync files
- [Evernote](http://evernote.com/): take notes
- [miketex](http://miktex.org/): LaTex distribution
- [Lyx](http://www.lyx.org/): GUI of LaTex
- [Zotero](https://www.zotero.org/): reference manager
- [Sublime Text](http://www.sublimetext.com/): text editor
- [Notepad++](http://notepad-plus-plus.org/): text editor
- [Foxit pdf reader](http://www.foxitsoftware.com/Secure_PDF_Reader/): great pdf annotator

#### System relevent:
- [7zip](http://www.7-zip.org/download.html): compress/extract files
- [Everything](http://www.voidtools.com/): powerful file search engine
- [DisplayFusion](https://www.displayfusion.com/): Dual monitor assistant
- [CCleaner](http://www.piriform.com/CCLEANER): Windows sucks!
- [Launchy](http://www.launchy.net/): open program fastly

#### Others:
- [Youdao](http://cidian.youdao.com/index.html): an English dictionary
- Google Pinyin 3.0: for its English writing assistant
- [foobar2000](http://www.foobar2000.org/): music player

Most of the above softwares I can find under Ubuntu, but the *Foxit pdf reader*, *Evernote*, *Everything*, *Youdao* and *Google Pinyin 3.0* were missing! They are the main reason that I am still using Windows...

## Environment variables
One thing I really hate with Windows is that I need to set up environment variables by hand if I want to get them recongnized in the commend line. Here are a list of changes in environment variables I made today.

- R: `R.home('bin')` then add the return `C:\Program Files\R\bin`.
- Github: add `C:\Users\Li\AppData\Local\GitHub\PortableGit_...\bin`.
- LaTex: no need to, already added when install.
- Lyx: in `Lyx --> Tools --> Preference --> path`:
     - PATH prefix, add R: `C:\Program Files\R\bin`.
     - lyxServer pipe, add `\\.\pipe\lyxpipe` for lyz of Zotero.
