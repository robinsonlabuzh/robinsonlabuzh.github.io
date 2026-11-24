# Robinson lab website

The site is built with [Quarto](https://quarto.org) from the `.qmd` pages in this repository. Every push to `master` is built and published automatically by GitHub Actions (`.github/workflows/publish.yml`), and the site is also rebuilt every Monday so the publication list stays current. The generated HTML is not stored in the repository.

### Updates to the website

- Create a branch, edit the relevant `.qmd` page (or `people.yml` for lab members), commit, push and open a pull request (see below). GitHub Actions builds the site for every pull request, so a red cross on the pull request means the site no longer builds.
- Once the pull request is merged into `master`, the site is rebuilt and published automatically, usually within a few minutes. Progress is shown in the repository's Actions tab.
- You do not need to build the site yourself, but you can preview it locally before pushing (see [Building locally](#building-locally)).

### Pull requests

Please do not push to master. Instead, create a separate branch, add your changes to this branch, push it to GitHub and create a pull request to the master branch. This pull request needs to be reviewed by someone else in the group, who will also merge it into the master branch if he or she approves the changes. The procedure is described in more detail below. 

You can create the new branch either on your local machine, or on GitHub. If you are creating it locally, first make sure that you have the latest changes to the master branch available, and create a new branch from this state (replace <new_branch_name> with the name you want to give your branch. Ideally this should describe what changes you are intending to make):

```
git checkout master
git pull
git checkout -b <new_branch_name>
```

To create the branch on GitHub, click on the branch selector menu and type a unique name into the text box, and click enter. Then pull the repository from GitHub to your computer (or, if the changes are minor, files can be edited directly on the github website by clicking on the pencil button [edit this file]). 

After making a new branch, make the necessary changes to the files on your local machine, add them to the index and commit them, and then push your new branch to GitHub. If you have created the branch locally, you need to set the remote accordingly, as follows: 

```
git push --set-upstream origin <new_branch_name>
```

After pushing your changes to your branch, go to the GitHub repository and create a pull request (you will see a yellow ribbon on the top of the page, indicating that new changes has been made to the branch you just pushed - click on the green button to create a pull request. Alternatively, go to the Pull requests tab and create a new pull request). Make sure that you select the right base fork (robinsonlabuzh/robinsonlabuzh.github.io) and branch (master) to send the pull request to. After selecting this, assign a reviewer. This is done in the right-side panel of the pull request page (click on the little wheel next to "Reviewers"). Select someone that is well suited to review your changes. This person will receive an e-mail with the invitation to review your pull request. Once you have done this, you are done, and you need to wait for the reviewer to check your changes and merge the pull request into the master branch. You will get an email confirmation if the reviewer comments on the pull request, or merges it. 

If you are invited to review someone else's pull request, take some time to go through the modifications and ensure that they are reasonable. You can pull down the changes and make additional modifications, and then push them back to the same branch. When you are satisfied (and this may require discussion with the person submitting the PR), merge the pull request. After merging the pull request, delete the new branch (you will get a message saying that "it is now safe to delete the new branch"), to avoid branches stacking up in the GitHub repo.

If you are continuing to work on a local branch after someone else has made changes to the GitHub repo master branch, it is often easier to merge the master branch into your local branch before pushing your local branch to GitHub, and resolve any merge conflicts locally:

```
git checkout master
git pull
git checkout <your_branch>
git merge master
```

### Adding publications

The publication list (generated from `publications.qmd`) is automatically populated when the website is built, by pulling down and reformatting PubMed results for the search `Robinson Mark D[au]`, using the [`rentrez`](https://cran.r-project.org/web/packages/rentrez/index.html) R package. Most of the time the results are correct, but since there are multiple authors named "Mark D Robinson" in the database, the list of publications should occasionally be checked for correctness. 

Also [bioRxiv](https://www.biorxiv.org/) preprints can be included, by explicitly providing the corresponding DOIs. 

The following parts of `publications.qmd` may need to be modified (all done within the first code chunk):

- The list of incorrectly pulled down PubMed publication records (`pmid_remove`). Once a PubMed ID has been added to this list, it will be excluded from all future renderings of the publication list. 
- The list of PubMed IDs to add manually (`pmid_add`).
- The list of bioRxiv preprints to include (`biorxiv_dois`).
- Links to GitHub repositories or software packages accompanying a paper or preprint. 

### Adding members

Lab members are listed in `people.yml`, in the order they appear on the people page; the format is described at the top of that file. To add someone, copy an existing entry and change its content. Put the photo in `img/thumbnail/` and make sure it is less than 100KB (see below for tips on image optimization); there is no need to also commit the full-size original. When someone leaves, delete their entry from `people.yml` and add a line to the Alumni list in `people.qmd`. Commit your changes to a new branch, submit a pull request and assign a reviewer (follow the explanations above on how to create a pull request).

### Tips on image optimization

When uploading images please bear in mind their format and filesize, as unnecesarily big files will require longer loading times and thus will impact web performance. We recommend following the [good practices by Ryan Boudreaux](https://www.techrepublic.com/blog/web-designer/tips-for-optimizing-your-web-images/): in brief, small JPGs (less than 100 KB) are preferred for high end photographs.

Images can be compressed using an image editor (i.e. Gimp) or in bulk (i.e. with [Imagemagick](https://www.imagemagick.org/script/index.php)). We provide a [thumbnail generator](https://github.com/robinsonlabuzh/robinsonlabuzh.github.io/blob/master/utils/bulk_thumbnail_generator.sh) based in Imagemagick for batch resizing. To run the thumbnail generator place your original image(s) at the folder encoded at `$INPUT_PATH` (the variable is set to the current directory `.` by default) and execute the bash script, which will generate an output folder (variable `$OUTPUT_PATH`, by default `$INPUT_PATH/thumbnail`) with the compressed images.

Keep in mind that compression is a trade off between file size and quality, so keep a lossless copy of the original image yourself; it does not need to be committed. Pages and `people.yml` should point to the compressed images in [img/thumbnail](https://github.com/robinsonlabuzh/robinsonlabuzh.github.io/tree/master/img/thumbnail).

### Building locally

Install [Quarto](https://quarto.org/docs/get-started/). To preview a single page while you edit it (it reloads in the browser whenever you save):

```
quarto preview people.qmd
```

Only `publications.qmd` runs R code. Every other page, including the people page, needs nothing but Quarto. To build the whole site into `_site/`, you also need R 4.6 and [rv](https://a2-ai.github.io/rv-docs/), which installs the R packages pinned in `rv.lock` (from [Posit Package Manager](https://packagemanager.posit.co)) into a project library under `rv/library/`. The `.Rprofile` activates that library whenever R starts in this folder. Then run:

```
rv sync
quarto render
```

To add an R package, run `rv add <package>` and commit the updated `rproject.toml` and `rv.lock`.

The publications page queries PubMed, bioRxiv/medRxiv and arXiv, so a full build takes a few minutes, and fails if one of those services is down or rate-limiting. In that case the live site keeps the last successful build.

### Publishing

GitHub Pages serves the output of the "Build and publish website" workflow (repository Settings → Pages → Source: GitHub Actions). The workflow runs on every push to `master`, every Monday at 05:00 UTC, and on demand from the Actions tab ("Run workflow"). Pull requests are built but not published. Optionally, an NCBI API key (created under *API Key Management* in your [NCBI account settings](https://www.ncbi.nlm.nih.gov/account/settings/)) stored as the repository secret `ENTREZ_KEY` raises the PubMed rate limit.
