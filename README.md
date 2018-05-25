# Robinson lab website

This is a template that we forked from [here](https://github.com/privefl/rmarkdown-website-template) for the basic structure and added many components.

More details on making HTML documents from Rmarkdown can be found [here](http://rmarkdown.rstudio.com/rmarkdown_websites.html).

### Updates to the website

- Once you've cloned the repo and have all the packages installed, the updating the website is done via:

```
rmarkdown::render_site(encoding = "UTF-8")
```

- Then, commit and push everything back to the robinsonlab.github.io repo

### Pull requests

Please do not push to master. Instead, create a separate branch locally, add your changes to this branch, push it to GitHub and create a pull request in the master branch. This pull request needs to be reviewed by someone else in the group, who will also merge it into the master branch if he or she approves the changes. The procedure is described in more detail below. 

First make sure that you have the latest changes to the master branch available locally, and create a new branch from this state (replace <new_branch_name> with the name you want to give your branch. Ideally this should describe what changes you are intending to make):

```
git checkout master
git pull
git checkout -b <new_branch_name>
```

Then make the necessary changes to the files on your local machine, add them to the index and commit them, and then push your new branch to GitHub as follows:

```
git push --set-upstream origin <new_branch_name>
```

Then go to the GitHub repository, and create a pull request (you will see a yellow ribbon on the top of the page, indicating that new changes has been made to the branch you just pushed - click on the green button to create a pull request. Alternatively, go to the Pull requests tab and create a new pull request). Make sure that you select the right base fork (robinsonlabuzh/robinsonlabuzh.github.io) and branch (master) to send the pull request to. After selecting this, assign a reviewer. This is done in the right-side panel of the pull request page (click on the little wheel next to "Reviewers"). Select someone that is well suited to review your changes. This person will receive an e-mail with the invitation to review your pull request. Once you have done this, you are done, and you need to wait for the reviewer to check your changes and merge the pull request into the master branch. You will get an email confirmation if the reviewer comments on the pull request, or merges it. 

If you are invited to review someone else's pull request, take some time to go through the modifications and ensure that they are reasonable. Then merge the pull request. After merging the pull request, delete the new branch (you will get a message saying that "it is now safe to delete the new branch"), to avoid branches stacking up in the GitHub repo.

If you are continuing to work on a local branch after someone else has made changes to the GitHub repo master branch, it is often easier to merge the master branch into your local branch before pushing your local branch to GitHub, and resolve any merge conflicts locally:

```
git checkout master
git pull
git checkout <your_branch>
git merge master
```

### Adding publications

The publication list (`publications.html`, generated from `publications.Rmd`) is automatically populated when the website is built, by pulling down and reformatting PubMed results for the search `Robinson Mark D[au]`, using the [`rentrez`](https://cran.r-project.org/web/packages/rentrez/index.html) R package. Most of the time the results are correct, but since there are multiple authors named "Mark D Robinson" in the database, the list of publications should occasionally be checked for correctness. 

Also [bioRxiv](https://www.biorxiv.org/) preprints can be included, by explicitly providing the corresponding DOIs. 

The following parts of `publications.Rmd` may need to be modified (all done within the first code chunk):

- The list of incorrectly pulled down PubMed publication records (`pmid_remove`). Once a PubMed ID has been added to this list, it will be excluded from all future renderings of the publication list. 
- The list of PubMed IDs to add manually (`pmid_add`).
- The list of bioRxiv preprints to include (`biorxiv_dois`).
- Links to GitHub repositories or software packages accompanying a paper or preprint. 

### Adding members

### Adding news item

## Template examples

Previous examples of this website template:
- [personal website](https://privefl.github.io/)
- [R user group in Grenoble](https://r-in-grenoble.github.io/)
