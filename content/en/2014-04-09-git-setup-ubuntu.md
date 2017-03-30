---
title:  Git setup and using under Ubuntu
date: '2014-04-09'
slug: git-setup-ubuntu
---
>This post will be update over time along with my git learning.

## Set up

In Ubuntu, it is super easy to install and set up Git. Bascially, just follow the online [reference](http://git-scm.com/docs).

	sudo apt-get install git
	git config --global user.name "daijiang"
	git config --global user.email "daijianglee@gmail.com"
	git config --global color.ui auto
	git config --global core.editor subl # set default editor
	git config --global core.excludesfile ~/.gitignore_global
	git config --global credential.helper 'cache --timeout=10000000' # if you do not want to type password everytime.

I put the following things in the `~/.gitignore_global` file:

	*~
	.*~
	.Rproj.user
	.Rhistory
	.RData
	*.Rproj
	*.pdf


That's it! You can check all of your config information by `git config --list`. If you want to know how to use a commend of git, simply using `man git-commend`, e.g. `man git-add`, `man git-pull`.

## Basic steps

#### Initialization

Then I want to create a directory named as "github" and clone my repositories into this directory. If your repository is private, then git will ask you for username and password.

	mkdir github
	cd github
	git clone URL
	# git clone URL path/to/
	cd newProject

If I already have a directory and want to version control that one, `cd` to the directory:

	git init
	git add *.txt # to track all txt files
	git commit -m 'initial project version'
	git commit # will open editor, add comments at there

#### Track files

After then, if you modified a file, you can use the following code to version control files.

	git status # check the status of the project
	git diff # check what has been changed (file not staged yet)
	git diff ee456 # diff since commit ee456
	git add filename # send file to staged
	git diff --staged # file already staged but not committed
	git commit -m 'message'
	git commit -a # all files, and you can skip the stage step by doing this

You can also rename files by using `git mv namea nameb`. This is equal to: `mv namea nameb; git rm namea; git add nameb`.

#### Untrack files

How about files you do not want to track? If you tracked them before, use `git rm filename` to untrack and delete it. If you want just to untrack it and want to keep it in the working directory, use `git rm --cached filename`. If you do not want track them at the beginning, put their names in the `.gitignore` file in the directory. Here is an example of the `.gitignore` file:

	*.a # ignore all .a files
	!lib.a # except this file
	/a.txt # ignore a.txt file in the root, but not subdir/a.txt
	dire/ # ignore all files in dire directory

#### History

`git log`: check history of a project. Here are some common options:

	git log -p # show diff of each commit
	git log -2 # the latest two commits
	git log --graph
	git log --stat # only show number of lines changed
	git log --shortstat
	git log --name-only # or --name-status
	git log --abbrev-commit
	git log --relative-date
	git log --pretty=oneline # oneline for each commit
	git log --pretty=short # other options: full, fuller
	git log --pretty=format:"%h - %an, %ar : %s"
	git log --since=2.weeks # commits of the latest two weeks
	git log --since='2002-01-16' # or = '2 years 1 day 3 minutes ago'
	git log --pretty=oneline -- dire/ # only check history of dire directory

In order to check an older version of a file:

	git show HEAD~3:path/to/file/from/root.tex
	    # show the version of root.tex from the 3rd latest commit
	git checkout 911ead

#### Undo actions

	git checkout -- file.name # undo the modification in file.name (unstaged)

	git reset HEAD filename # unstage file

	# undo the latest commit
	git commit -m 'bad commit'
	git add forgotten.file
	got commit --amend # use the staged dire to edit the last commit

	# delete the last commit
	git reset --hard HEAD~1

	# abandon all local changes
	git fetch origin
	git reset --hard origin/master

#### Branch

Git will reset the working directory when you switch branches. Make sure to commit everything before switch branch.

	git checkout -b branch.name # create and switch to a new branch.
	  # equal to git branch branch.name; git checkout branch.name
	git commit -a -m "message here" #After finish working, commit all things.
	git push origin branch.name # push the branch to github
	git checkout master # back to the origin master branch
	git merge branch.name # merge all changes in branch.name to master branch
	git branch -d branch.name # delete it after merging. Since it equals with master now.
	git push origin --delete branch.name # delete from github.

Instead of merge, one can also use `git rebase master` in the branch to apply all changes in the current branch in the master branch. This will make the master branch updated but still keep both branches (`git checkout master; git merge branch.name`).
If two branches changed the same part of a file, there will be merge confliction. Use `git status` to check unmerged file names. The confliction can be located between `<<<<<<<` and `>>>>>>>`, seperating by `=======`. You can choose one of them or edit by yourself. After then, `git add` to stage them and then `git commit` if satisfied.

	git branch # check all branches list.
	git branch -v # check last commit of all branches
	git branch --merged # branches have been merged into current branch
	git branch --no-merged # branches have not ...
	git branch -d branch.merged # delete branches already merged
	git branch -D branch.not.merged # dangerous! Are you sure? -D will force to delete.

##### stashing

When you work on some project which is not ready to commit, but at the same time you need to switch to another branch. You can use stashing: store the current working.

	git stash # store current work
	git stash list # a list of stashed works
	git stash apply stash@1 # apply stashed work on the same or different branch.
	git stash apply --index # if you want also apply staged changes.
	git stash drop stash@{0} # remove stashed work
	git stash branch branch.name # create a branch, get the stashed work, apply changes,
	  # drop stashed work if success.

#### Pull from Github to update
You can simply use `git pull` to update your local project from Github. If you changed something in your local project, and want to apply the online update first before you push your changes. You can use `git fetch origin` and then `git rebase origin/master` or `git rebase origin/gh-pages` for webpages. This will include online changes whereas keep your changes on top.

#### Push to Github

Go to [github](https://github.com/), login, create a new repository, and follow their instruction.

If you want to use SSH key when you push things to github, see [here](https://help.github.com/articles/generating-ssh-keys). Then you need change the url of your local repository, following [this page](https://help.github.com/articles/changing-a-remote-s-url).

## Reference

+ [Git Pro book](http://git-scm.com/book)
+ [Karl's tutorial](http://kbroman.github.io/github_tutorial/)
