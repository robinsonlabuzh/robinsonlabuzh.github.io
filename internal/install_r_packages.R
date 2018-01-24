# Author: Keith Satterley (WEHI) originally, modifications from Mark Robinson and others
# Last Modification: 2018-01-23

## Set mirrors to use
options(BioC_mirror = "http://bioconductor.statistik.tu-dortmund.de",
        repos = "http://stat.ethz.ch/CRAN")

## Source biocLite
source("http://bioconductor.org/biocLite.R")
biocLite()

## Set library path
library(BiocInstaller)
(Lib <- .libPaths()[1])

## Run biocLite to get standard set of packages
biocLite(ask = FALSE, lib = Lib)

## Data/annotation packages
biocLite(pkgs = c("BSgenome.Hsapiens.UCSC.hg38", "BSgenome.Mmusculus.UCSC.mm10",
                  "BSgenome.Dmelanogaster.UCSC.dm6", "BSgenome.Scerevisiae.UCSC.sacCer3",
                  "BSgenome.Drerio.UCSC.danRer7", "org.Hs.eg.db", "pasilla",
                  "PasillaTranscriptExpr", "GeuvadisTranscriptExpr", "airway"), 
         lib = Lib, ask = FALSE)

biocLite(pkgs = c("pd.yg.s98", "ygs98.db", "genomewidesnp6Crlmm",
                  "pd.genomewidesnp.6", "pd.hugene.1.1.st.v1",
                  "hugene11sttranscriptcluster.db", "SNPlocs.Hsapiens.dbSNP.20110815",
                  "IlluminaHumanMethylation450kprobe", "pd.huex.1.0.st.v2"),
         lib = Lib, ask = FALSE)

## Bioconductor "infrastructure" and data retrieval packages
biocLite(pkgs = c("GenomicFeatures", "Rsamtools", "BiocGenerics", "IRanges",
                  "rtracklayer", "ShortRead", "GenomicRanges", "biomaRt",
                  "GO.db", "GEOquery", "Biostrings", "BiocStyle", "BiocCheck",
                  "BiocWorkflowTools", "GenomicAlignments", "ensemblVEP",
                  "AnnotationDbi", "AnnotationHub", "ExperimentHub", "BiocParallel",
                  "ensembldb", "MultiAssayExperiment", "SummarizedExperiment",
                  "SingleCellExperiment"),
         lib = Lib, ask = FALSE)

## Analysis packages
biocLite(pkgs = c("oligo", "affxparser", "gcrma", "limma"), 
         lib = Lib, ask = FALSE)

biocLite(pkgs = c("tximport", "Rsubread", "edgeR", "DESeq2", "DEXSeq", 
                  "pasillaBamSubset", "easyRNASeq", "htSeqTools",
                  "cummeRbund", "QuasR", "DRIMSeq", "derfinder", "derfinderPlot",
                  "sangerseqR", "flipflop", "casper", "deepSNV",
                  "scater", "scran"),
         lib = Lib, ask = FALSE)

biocLite(pkgs = c("Repitools", "minfi", "bsseq", "bsseqData", "ChIPpeakAnno",
                  "methyAnalysis", "ChIPsim", "ARRmNormalization"), 
         lib = Lib, ask = FALSE)

biocLite(pkgs = c("gplots", "VennDiagram", "GenomeGraphs", "CrispRVariants",
                  "CoverageView", "ggbio", "Gviz"), 
         lib = Lib, ask = FALSE)

biocLite(pkgs = c("ROCR", "charm", "iCOBRA", "TEQC", "wateRmelon", "Genominator"),
         lib = Lib, ask = FALSE)

biocLite(pkgs = c("flowCore", "flowViz", "FlowSOM", "cytofkit", "spade",
                  "flowUtils"),
         lib = Lib, ask = FALSE)

## aroma.affymetrix and friends
source("http://www.braju.com/R/hbLite.R")
hbInstall("aroma.affymetrix")
hbInstall("aroma.core")

## CRAN
install.packages(c("rgl", "rglwidget", "rhandsontable", "pheatmap", "RJSONIO",
                   "Cairo", "shiny", "shinyBS", "shinydashboard", "shinyFiles",
                   "shinythemes", "UpSetR", "ggrepel", "cowplot", "gridExtra",
                   "gdata"), 
                 quiet = TRUE)

install.packages(c("devtools", "tibble", "dplyr", "tidyr", "ggplot2", "readr",
                   "reshape", "reshape2", "roxygen2", "pryr", "rvest", "seqinr", 
                   "httr", "testthat", "purrr"),
                 quiet = TRUE)

install.packages(c("data.table", "readxl", "knitr", "rmarkdown", "xlsx", 
                   "WriteXLS", "cacheSweave", "RPostgreSQL", "json", "rjson",
                   "argparse", "stringdist", "rhdf5"),
                 quiet = TRUE)

install.packages(c("multicore", "doMC", "foreach", "snowfall", "Rcpp"),
                 quiet = TRUE)

install.packages(c("mixtools", "Rsolnp", "fastcluster", "RPMM", "pixmap" 
                   "sp", "quantreg", "R.utils", "lme4", "multcomp", "nibble",
                   "refGenome", "caTools", "Hmisc"),
                 quiet = TRUE)

install.packages("expectile", repos="http://R-Forge.R-project.org")
              
## INLA
source("http://www.math.ntnu.no/inla/givemeINLA.R")

## zinba
system("wget http://zinba.googlecode.com/files/zinba_2.01.tar.gz")
install.packages("zinba_2.01.tar.gz", repos=NULL)  

## statmod
system("wget https://cran.r-project.org/src/contrib/statmod_1.4.21.tar.gz")
install.packages("statmod_1.4.21.tar.gz", repos = NULL)
         