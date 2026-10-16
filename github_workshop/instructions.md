# IT Ops Git workshop plan

## What we'll do today?

1. Working with Visual Studio Code
2. How to setup `git config` on your laptop
3. Local and remote repo & how to clone a repo
4. How to create, change and work with branches (basics)
5. How to add files (git add, git status)
6. How to commit changes
7. How to push changes to the branch
8. How to make changes to files in our repo using vs code
9. How to setup `gh` (github cli) on our laptop
10. How to use `gh` in order to create pull requests (basics)
11. How to delete local and remote branches

#### Let's GO! :) 

## Working with Visual Studio Code

VS code is your friend and ally. You can browse and work on all of your local repositories, use terminal, split windows, change/create branches etc.

Now, open Visual Studio Code and open `Terminal` from the top bar and choose `New Terminal` (key shortcut control+shift+`)

## Setup `git config` on your laptop

Now let's setup our local git config in order for any operations to reflect properly in Github - first type `git config --global core.editor nano` (this will setup nano as a default text editor) and then type `git config --global --edit` and amend as per:
```
# This is Git's per-user configuration file.
[user]
# Please adapt and uncomment the following lines:
        name = John Dee # ensure that matches your Github Profile
        email = john.dee@domain.com # ensure that matches your Github Profile
        username = githubuser # ensure that matches your Github Profile
```

Once you finish editing hit `control + X` and then type `Y` to approve changes and hit Enter 🙌

If you have configured it correctly, then on each push to remote repository (Github) it will show the correct github account 😎

## Local and remote repo & how to clone a repo

Basically as the name suggests local is whatever sits on your laptop where remote is the state on the Github (https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes). 
You need to remember that each time you make changes locally, they need to be synchronised (`pushed`) to the remote state as well.
You can do that manually or use ie. Visual Studio Code which we will do later ;) 

For now let's clone our first repository so in Visual Studio Code terminal
- navigate to ~
- create a new directory `mkdir github-workshop`
- change to that new directory `cd github-workshop`
- and clone your repo to it
```
git clone git@github.com:netguru/<nameoftherepo>
```

## How to create, change and work with branches (basics)

Why do we need branches? Well, imagine that you'd like to make some changes to your code or files in git but you don't want to synchronise them with the `main` repository (ie. because of automations and checks). So you can use `branches` to make copies of the main repo and start making changes on files and when everything is checked and ready you can `merge` those to the `main` or a different branch.

So now we have our `main` branch (you can check which branch you are currently working on in the VS Code in the bottom left corner) and in your terminal at the end of the path in yellow.

Let's create a new branch
```shell
git checkout -b changes
```

`git checkout` is the command to jump between branches or it can create them (you could also use `git branch <name_of_the_new_branch`). With -b flag we can create a new branch (ie. changes) and jump straight into it. This will also copy the current state of our local `main` branch into this new branch.

So now we have a branch called `changes` and we are in it - do you remember what you need to do in VS code and terminal to ensure they match? 

Before we move further, we need to ensure that branch is tracked and created in the Github
```shell
git branch --track 
git branch --set-upstream-to origin changes
```

Ok, so now let's create a new file!
use shortcut `command + n` to create a new file and add `hello world`
Now, let's save the file `command + s` and name it hello.txt (ensure you save it in our working folder git-itops-ws-<number>)

So file exists locally, next step will be to have the same file in Github 🚀

## How to add files (git add, git status)

So we have file created (it should be highligted in green as it was just created in the left pane of VS Code) (changes will register as orange)
What you can do is check what is the status of all changes (files)
```
git status
```
You will probably get something like 
```
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   README.md
```
That's great. So let's add the file to the git remote.

```shell
git add . 
```
(the `.` will add all changed/created files)

let's try `git status` again - files are ready to be commited correct? 🙌

## How to commit changes

Commiting changes is like putting those changed files in a queue for when they are ready to be sent to an upstream repository (remote repo). Since we are happy with changes we made we can start commiting the file we have created earlier `hello.txt`

```shell
git commit -m "first commit"
```

What just happened is that we have told git to create a commit with a message (-m flag) saying `first commit`. When we type `git status` we will see it's ready to be synchronised to the remote repository (pushed).

**One thing to remember: when you commit you put all files you have added earlier to a commit queue. So if we had edited or created more files earlier when we typed `git add .` all those files are then added and ready for the commit.**

  
## How to push changes to the branch

So now we have files ready in the queue - but they are not visible in the remote repository (github) - they only still exists in our local repository - in this case branch `changes`. Let's update (push) to our branch in github.

```shell
git push --set-upstream origin changes # --set-upstream will create push and sync local with remote branch in github 
```

What will happen is that file `hello.txt` should now appear in our `changes` branch in github. Check if that's the case 👌🏻 
Worked, right? 💪

## How to make changes to files in our repo using vs code

Ok, so now let's do something more practical. Let's use VS Code to work on multiple files and push them to our branch

I have sent you a .zip package - unzip it to the repo you are working at. Let's use commandline for that
```shell
unzip <path to zip>
```

Zipped files should unpack to a folder called `files` in our directory in branch `changes`. Correct?

Ok, so now let's use the search menu in VS Code on the left hand side (or use `command+shift+F`)

Type `neo` and you can see all of the files containing that word. When you click on the result the file will open in the main window and you can start editing it. Let's change `neo` github nick to `trinity`. Then let's save using `command + s`.

Ok so what would we need to do in order to now push all those new files and changes to github repository?
>tip add,commit,push :)
Try it

Now imagine you could edit numerous files in the vs code and then just push those changes at once to remote repository in github 🕺

Let's change some stuff then. Change another 2 files (do whatever you wish) and delete anothe 3 (choose which). 
You can remove file using terminal by
```shell
rm <filename>
```

If you delete file `git` will treat it as you've made a change and will remove all content and the file when you add, commit and push changes. Try it now!

> Add   Commit   Push

## How to setup `gh` (github cli) on our laptop

So we have played with files and changes etc. Let's start wrapping it up and let's use `gh` (github's cli tool) in order to start merging changes to the `main` repository

Authorize to gh by `gh auth login`. gh provides visual options so you can navigate using tab or arrows. 
Choose SSH as the method of authentication (providing you have generated and added SSH key to local agent and in github)
You can skip uploading ssh key as you have done it before.
Login with web browser and follow instructions.
And voila - you can start using `gh` cli tool.

## How to use `gh` in order to create pull requests (basics)

We have pushed all of the files and changes from the local `changes` branch to the one in Github. (you can double check by heading to your repo, changing branch and verifying all files are there).

Let's now create a push request using `gh` (you can do the same using web browser but this is way cooler ;)

```shell
gh pr create
```

What gh will do is it will recognise you are trying to merge content from `changes` branch to the `main` branch and will ask you some questions to create the pull request (either full from the command line or in web browser).

Whichever method you try you will end up with a PR (pull request) - meaning all changes from `changes` branch are ready to be merged into the `main` branch both locally and in github (remote).

You can merge using `gh pr merge <pull request number> --auto` or by using the web browser. By doing it using `gh` cli provides you the ability to delete the branch locally and on Github to keep things clean.

## How to delete local and remote branches

Now that we have completed our work we can remove the local and remote branch.
In order to delete local branch make sure you are in the `main` branch (use `gh checkout` command if required)

Then
```shell
gh branch -d changes # -d flag means delete
```

And head over to Branches in Github and delete the branch `changes` there as well.

Btw, don't forget you can always recover branches in Github 😀
