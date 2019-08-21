---
title:  First experience with CHTCondor
date: '2014-06-21'
slug: htcondor-experience
---
I am diving into lots of random subsampling a big quadrats by species matrix and then doing some analysis on each random subsampled matrix. For example, we have a big dataset which includes vegetation survey data for three vegetation types and two time periods for each vegetation type. For each vegetation type and time period, in order to standardize sampling effort, I need to sub sample 28 sites with 20 quadrats for each site 5000 times. This will give me 5000 * 6 = 30000 quadrats by species matrix. For each of these matrix (560 rows and 100-300 columns), I need to do some analysis and this will cost about 5 - 10 minutes (involving with null models: reshuffling each matrix another 5000 times to get effect size and p-value). I am doing all of this using R. As R is RAM limited, this job is far far more than what I can handle with my laptop or desktop (6Gb RAM with 4 cores).

Fortunately, we have a [center for high throughput computing (HTC)](http://chtc.cs.wisc.edu/) on campus. Specifically, the [HTCondor Project](http://research.cs.wisc.edu/htcondor/) for my case. The idea is that split the job into lots of *n* small pieaces of jobs and then send them to *n* computers (wither campus-wide or national-wide). Then each computer will finish that small job and send results back. Since I am using R for all analyses, I also need to ship the R program and extra packages I used with data and code to these *n* computers. As a result, we need follow [two steps](http://chtc.cs.wisc.edu/howto_overview.shtml) to make it. However, the [help](http://chtc.cs.wisc.edu/howto_overview.shtml) page is not documented very well. Thought the computing facilitator is very nice and at the first meeting, s/he problably will teach you how to use the system. But I feel at the first time, if you have no previous experience about using `ssh` before like me, you probably will be overwhelmed. Here I recorded my experiences with using R with HTCondor, step by step.

Before doing anything with HTCondor, you need to get access to it. Talk with your computing facilitator to set up an account for you.

1. Building R in the submit node. Following the [help page](http://chtc.cs.wisc.edu/MATLABandR.shtml) will be fine here. What bothered me is *what/where is a submit node? Where should I run the code to build R?*. I still not quite sure about where is the submit node. Is it the home directory `~` or the directory where my data and actually code for analysis located? I just run the R building code in my home directory.

	1. First, download source code of R packages you needed for your analysis (if any, e.g. *vegan_2.0-10.tar.gz*). Then transfer them to your home directory: `scp *.tar.gz user@submit-3.chtc.wisc.edu:.`. `*` matches anything, `.` at the end means keep names as is.
	2. Then login into your account and build R: `chtc_buildRlibs --rversion=sl5-R-3.0.1 --rlibs=permute_0.8-3.tar.gz,vegan_2.0-10.tar.gz`. The order of packages matters, as the help page said. *Libraries that are called by other libraries should be listed first.*

2. 	Then we are going to step two. Again, just follow the [help page](http://chtc.cs.wisc.edu/DAGenv.shtml).

	1. Make a directory to hold everything for your project and set it as working directory. 
			
			mkdir project-name
			cd project-name

	2. Download the ChtcRun package and unpack it

			wget http://chtc.cs.wisc.edu/downloads/ChtcRun.tar.gz
			tar xzf ChtcRun.tar.gz

	3. Transfer your data and files into directories within `ChtcRun` directory, following the help page. Using the `Rin` directory came with the ChtcRun package as an example. You put your analysis R code for each job in the `Rin/shared` directory. **Also, copy the two compact files produces from step one into this file folder!!!** This point is not on the help page! The two files, in my case, are `sl5-RLIBS.tar.gz` and `sl6-RLIBS.tar.gz`. So within the `Rin` directory, move them use `cp ~/sl*-RLIBS.tar.gz shared/.`. Then within `Rin` directory, create one file folder for each job, just follow the help page will be fine.
	4. Within `ChtcRun` directory, submit your jobs. Here is an example: suppose all of your data and files within `Rin` directory and you want your output to be in the `Rout` directory. The R code is `code.R` in the `Rin/shared` folder. Also, for each job, you will get three files back, say `a.csv`, `b.csv`, and `c.csv`. And you want all your result files in a `Rresult` file folder. Then you can run code as this:
	
			./mkdag --data=Rin --outputdir=Rout --resultdir=Rresult --cmdtorun=code.R \
			--pattern=a.csv --pattern=b.csv --pattern=c.csv \
			--type=R --version=R-3.0.1
			cd Rout
			condor_submit_dag mydag.dag

That is it! Now you have submitted your jobs and you want to check the progress. You can use `condor_q $USER` to check how many jobs are running, how many are in quene. You can also use `less mydag.dag.dagman.out` in the `Rout` directory (then press `space` to view the out file page by page, or press `G` to go to the end of the file). It will tell you how many jobs have been done, how many are running, etc. 

![Imgur](https://i.imgur.com/LwfOE4C.png)

At the end, I want to list some important points:

+ In your local computer, create one file folder for each job and then put data for each job in the file folder. In my case, I need to create 30000 file folders and put each sub-matrix in. Then transfer all file folders into your account: `~/project1/ChtcRun/Rin/`.
+ In `Rin/shared` directory, paste the R packages build in step one. This is because when HTCondor send your jobs to different computers, each computer needs your data, code and R packages.
+ You can use `--pattern=` to identify your results and collect them in one directory.
+ You need to know some [basic shell commands](http://www.daijiang.name/en/2014/03/02/Unix-commands/).
		
