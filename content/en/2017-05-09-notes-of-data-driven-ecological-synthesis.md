---
title: Notes of Data-driven Ecological Synthesis
date: '2017-05-09'
slug: notes-of-data-driven-ecological-synthesis
---

I went to the excellent data-driven ecological synthesis summer school at the [Station de Biologie des Laurentides (SBL)](http://www.sbl.umontreal.ca/index.html) of the Université de Montréal, organized and taught by Timothée Poisot and Dominique Gravel. The station is one of the best research station I have ever been: great view, nice staffs, and excellent food! The teachers are very approachable and very knowledgeable. Classmates are very nice to each other and we had lots of fun together. For example:

{{< tweet 860323102173134848 >}}

and

{{< tweet 859926804995465216 >}}

Thanks all for a great week.

{{< tweet 861268696135815169 >}}

********************

Here is my very brief note during this one-week class.

# 2017/05/01

- What is data? Observations of variables have value and unit. 
    + meta data: when, who, how, why, intel. property?

- Data plan? (NSF funded: data one, data life cycle <https://www.dataone.org/data-life-cycle>) (talked about 50 mins)
    1. collect 
    2. assure: quality control:
    3. describe: meta-data?
    4. preserve: backup, ask computer center of University; figshare, etc. Be careful with Dropbox if you have government data etc. long-term archive. Who can have access?
    5. discover: identify data you need, which not necessary collected by yourself.
    6. integrate: put different temporary/spatial scales data together
    7. analysis: overview of the data analyses to conduct.
- exercise: 2-3 people/group, read a paper selected by themselves, discuss 2-3 steps of the data life cycle, how they did that? weakness? good? 20-30 mins. 

- Be serious about data archive/integration when applying for funding / writing grant reviewing.

- [Ten Simple Rules for Creating a Good Data Management Plan](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1004525)
- [Ten Simple Rules for Digital Data Storage](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005097)
- Spreadsheet: flat files
    + type `SEP3`, `sept03`, or `sep03`; and excel turned it into `3-Sep` or `9/3/2017`. Even save as csv file at the end, they are all `3-sep`, not what you typed in.
    + tidy data: every column as variable, every row as an observation.
    + NO THINGS: no merging cells, no color, no blank cells (be explicit about missing data and other possible issues that will result in missing data), no single information (no multiple tables)
    + dates: YYYY-MM-DD-HH-MM-SS-TZ or split into date, time, and time zone.
    + Location coordinates: be explicit about the format. 
- Template: use template to input data at the beginning of projects; when explain the variables, be explicit about possible values or rules to record. For example, how to name a site; for species, use Latin names; format of dates; etc.
- Exercise: everyone creates a template for their own projects. 30 mins.

# 2017/05/02

- OpenRefine (morning)
    + explore different datasets: facets, transform of cells, filtering of rows, transform cells, explore scatter plots, e.g. `[value, cells["mo"].value, cells["dy"].value].join("-")`
    + input datasets by multiple urls. 
        +  json files, select "rows" instead of "records" to make life easier. 

- Jupyter notebook + R (afternoon)
    + a little bit of data manipulation.
    + `parallel with plyr`: `library(doMC); registerDoMC(detectCores() - 1); ddply(.parallel = T)`
    + Book recommendation: [The Pragmatic Programmer: From Journeyman to Master](https://www.amazon.ca/Pragmatic-Programmer-Journeyman-Master/dp/020161622X)

# 2017/05/03

- Morning
    - Group discussion about mandatory data sharing/open (for and against, 2 groups, morning 45 mins)
        + debate.
        + For: drive to a better science system (system > individuals)
        + Against: unfair (synthesis vs data collectors;)
    - Data sets and API (request/url and responses/json object); rOpenSci project/packages.
- Afternoon
    - Discussion about possible projections till 3pm
    - Dom gave a talk about how public data can do. (*Beyond the checklist: the biogeography of ecological interaction networks*)
        + *biogeograph*: spatial and temporal distribution of species and abundance, including causes and consequences.
        + the dominant conceptual tool in biogeograph: the niche. 
        + Is resource availability constant across gradients?
        + predation pressure constant across gradients?
        + how do covary interaction strength and pop abundance
        + what about highly diverse communities?
        + A community is more than a checklist
        + how do we move from a regional meta web to a local web?
        + revise *biogeograph* by including species interaction
        + Gravel et al 2011 Ecol. Lett.
        + OBIS: marine occurrence data set.
        + fishbase: fish characteristics.
        + connectance very high in global Marian fish networks
        + how do you control for data quality? *with huge datasets, the impact of errors may be not too problematic.* More importantly, with complex pipeline of scripts, be careful about possible programming errors. *defensive programming*
        + be careful about sensitivity of data analyses to data quality.
    - talking about designing database.
        + be defensive when design: for example, set types of possible inputs (characters, small integers, etc. error control), api design (JavaScript), advantages of api: security, portability, remote working.

# 2017/05/04

- Morning
    + Dom. Gravel suggested books 
        * _An Illustrated Guide to Theoretical Ecology_ by Ted J. Case
        * _The Theoretical Biologist's Toolbox: Quantitative Methods for Ecology and Evolutionary Biology_ by Marc Mangel 
    + Rational data bases
        * advantages: efficiency, security, remove redundancy, faster query, allow multiple users work on the dataset at the same time
        * SQL: structural query language

                SELECT sphote AS host, sppar AS parasite, COUNT(sppar) AS number, AVG(a) AS a
                FROM morphometry 
                WHERE host is "Disa"
                GROUP BY sphote, sppar
                HAVING number > 3
                ORDER BY number DESC
                LIMIT 4

        * [SQL ecology data carpentry](http://www.datacarpentry.org/sql-ecology-lesson/) 
- Afternoon
    + Brief about projects to work on. (4 projects, and I work on my own project)
    + Work on projects

# 2017/05/05

- Morning
    + Git/Github: common words e.g. repository, stage, commit, branch, merge
    + License: [choose a license](https://choosealicense.com/appendix/)
    + github commit emoji `:books: comments here`; `:sparkles: comments` [list of emoji](https://github.com/slashsBin/styleguide-git-commit-message) :bug:
    + Illustrate collaboration via github
    + Optimization coding
        * [R high performance tutorial](http://dirk.eddelbuettel.com/papers/useR2010hpcTutorialHandout.pdf)
        * [Hadley's optimising code chapter](http://adv-r.had.co.nz/Profiling.html#performance-profiling): went through the R code a little bit.
- Afternoon
    + work on project. 

# 2017/05/06

- Work on project the whole day.

# 2017/05/07

- Morning
    + Work on project; started group presentations at 10:30am, till 12pm.
- Afternoon
    + Back to Montreal at 3:30pm.
