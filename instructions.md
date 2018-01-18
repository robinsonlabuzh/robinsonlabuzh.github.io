## Instructions for building and updating the website

The website is built with the following `R` command:

```
rmarkdown::render_site(encoding = "UTF-8")
```

This will build all `.Rmd` files in the directory to the corresponding `.html` files. After building the website with the command above, you can view the result locally and push the changes to the GitHub repo. If there are problems with the rendering, try updating `R`, `RStudio` and/or the `rmarkdown` package. 

### Publication list
The publication list (`publications.html`, generated from `publications.Rmd`) is automatically populated when the website is built, by pulling down and reformatting PubMed results for the search `Robinson Mark D[au]`, using the [`rentrez`](https://cran.r-project.org/web/packages/rentrez/index.html) R package. Most of the time the results are correct, but since there are multiple authors named "Mark D Robinson" in the database, the list of publications should occasionally be checked for correctness. 

Also [bioRxiv](https://www.biorxiv.org/) preprints can be included, by explicitly providing the corresponding DOIs. 

The following parts of `publications.Rmd` may need to be modified:

- The list of incorrectly pulled down PubMed publication records (`pmid_remove`). Once a PubMed ID has been added to this list, it will be excluded from all future renderings of the publication list. 
- The list of bioRxiv preprints to include (`biorxiv_dois`).
- Links to GitHub repositories or software packages accompanying a paper or preprint. These are added into the `github` and `software` columns of the final data frames, in the code chunks named `add_links` and `add_links_preprints`. 
