# Robinson lab website

This is a template that we forked from [here](https://github.com/privefl/rmarkdown-website-template) for the basic structure and added many components.

More details on making HTML documents from Rmarkdown can be found [here](http://rmarkdown.rstudio.com/rmarkdown_websites.html).

### Updates to the website

- Once you've cloned the repo, created a branch to make changes on, have all the packages installed, updating the website is done via the following commands (in R):

```
Sys.setlocale(category = "LC_ALL", locale = "en_US.UTF-8")
rmarkdown::render_site(encoding = "UTF-8")
```
- Then once you are happy with the look of the website, commit and push the files changed (RMD + HTML + any graphics) back to your branch, and send a pull request

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

The publication list (`publications.html`, generated from `publications.Rmd`) is automatically populated when the website is built, by pulling down and reformatting PubMed results for the search `Robinson Mark D[au]`, using the [`rentrez`](https://cran.r-project.org/web/packages/rentrez/index.html) R package. Most of the time the results are correct, but since there are multiple authors named "Mark D Robinson" in the database, the list of publications should occasionally be checked for correctness. 

Also [bioRxiv](https://www.biorxiv.org/) preprints can be included, by explicitly providing the corresponding DOIs. 

The following parts of `publications.Rmd` may need to be modified (all done within the first code chunk):

- The list of incorrectly pulled down PubMed publication records (`pmid_remove`). Once a PubMed ID has been added to this list, it will be excluded from all future renderings of the publication list. 
- The list of PubMed IDs to add manually (`pmid_add`).
- The list of bioRxiv preprints to include (`biorxiv_dois`).
- Links to GitHub repositories or software packages accompanying a paper or preprint. 

### Adding members

The members of the group are listed in the `people.Rmd` file. To add a new member, you can copy an existing entry and simply change its content. Add the path to your picture in the `img` component, but make sure that the picture is less than 100KB. The compressed picture should be saved in `img/thumbnails` (see below for tips on image optimization). Under `bio`, you can add a description of your research and your university degree(s). If you want, you can also add links to your website, twitter or github accounts. Commit your changes to a new branch, submit a pull request and assign a reviewer (follow the explanations above on how to create a pull request).

### Adding news item

News items can be added by simply cutting and pasting an existing snippet (i.e., a row of the `tbl_news` table) and filling in the new content (a few more details about line breaks, etc. are given in `news.Rmd`).  As usual, the news item should be created in a separate branch (see above), a pull request submitted and then peer-reviewed.  In this case, it should be approved by Mark so set the reviewer to be Mark.

### Tips on image optimization

When uploading images please bear in mind their format and filesize, as unnecesarily big files will require longer loading times and thus will impact web performance. We recommend following the [good practices by Ryan Boudreaux](https://www.techrepublic.com/blog/web-designer/tips-for-optimizing-your-web-images/): in brief, small JPGs (less than 100 KB) are preferred for high end photographs.

Images can be compressed using an image editor (i.e. Gimp) or in bulk (i.e. with [Imagemagick](https://www.imagemagick.org/script/index.php)). We provide a [thumbnail generator](https://github.com/robinsonlabuzh/robinsonlabuzh.github.io/blob/master/utils/bulk_thumbnail_generator.sh) based in Imagemagick for batch resizing. To run the thumbnail generator place your original image(s) at the folder encoded at `$INPUT_PATH` (the variable is set to the current directory `.` by default) and execute the bash script, which will generate an output folder (variable `$OUTPUT_PATH`, by default `$INPUT_PATH/thumbnail`) with the compressed images.

Keep in mind that compression is a trade off between file size and quality, so make sure you have a saved copy of the original image as a lossless version. To encourage a separation of originals and thumbnails the repository has a folder [img](https://github.com/robinsonlabuzh/robinsonlabuzh.github.io/tree/master/img) for the former and a subfolder [thumbnail](https://github.com/robinsonlabuzh/robinsonlabuzh.github.io/tree/master/img/thumbnail) for the latter. Note that `Rmd` and `html` files should point to the thumbnails, not to the originals.

### Running with Docker

In case there are issues with missing dependencies a possibility is to render the site in a docker container. Run the following in a terminal (assuming [docker](https://docs.docker.com/engine/install/) is installed):
```
docker run --rm -w /home/rstudio/webpage -v "$(pwd):/home/rstudio/webpage" retogerber/rstudio_robinsonlab_webpage:latest R -e "Sys.setlocale(category = 'LC_ALL', locale = 'en_US.UTF-8');rmarkdown::render_site(encoding = 'UTF-8')"
```


To run Rstudio in a docker container with all the necessary dependencies installed, run:
```
docker run --rm -v "$(pwd):/home/rstudio/" -p 8787:8787 -e PASSWORD=my_passwd retogerber/rstudio_robinsonlab_webpage:latest 
```
Then open your favorite browser and go to `http://localhost:8787/`. Login with username=*rstudio* and password=*my_passwd*.




## Template examples

Previous examples of this website template:
- [personal website](https://privefl.github.io/)
- [R user group in Grenoble](https://r-in-grenoble.github.io/)
