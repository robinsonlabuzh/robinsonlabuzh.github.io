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

Please do not push to master. To use a separate branch instead you could run this locally

```
git checkout master
git pull
git checkout -b <new_branch_name>
```

Edit the files in your machine, add and commit them and then push the changes to GitHub by

```
git push --set-upstream origin <new_branch_name>
```

On Github, make a pull request for merging your branch. Use the dropdown to select the branch your changes should be merged into, e.g. robinsonlabuzh master. You can assign the request to someune typing the username of the assignee at the select input on the right sidebar.

Once the pull request is merged by the assignee, it may be a good idea to delete the new branch (it will tell you “it is now safe to delete the new branch”), to avoid branches stacking up in the GitHub repo.

If you are continuing to work on a local branch after someone else has made changes to the GitHub repo master branch, it is often easier to merge the master branch into your local branch before pushing your local branch:

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
