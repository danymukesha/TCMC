
<!-- README.md is generated from README.Rmd. Please edit that file -->

# TCMC: Tool for Classification Model Comparison

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

## Overview

TCMC is made to facilitate the comparison of multiple classification
models using the caret package. It provides a streamlined approach to
train, evaluate, and compare 13 different classification algorithms,
offering the user a framework for model selection in machine learning
projects.

## What this tool does

- Trains and compares 13 different classification models
- Utilizes repeated cross-validation for robust performance estimation
- Provides variable importance plots for each model
- Generates confusion matrices for model evaluation
- Supports customizable training/test split ratios

## Installation instructions

Get the latest stable `R` release from
[CRAN](http://cran.r-project.org/). Then install `TCMC` from
[Bioconductor](http://bioconductor.org/) using the following code:

You can install TCMC from GitHub using the devtools package:

``` r
devtools::install_github("danymukesha/TCMC")
```

In the near future, you could also see it on Bioconductor

``` r
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
BiocManager::install("TCMC")
```

## Models Included

TCMC includes the following classification algorithms:

1.  Learning Vector Quantization (LVQ)
2.  Gradient Boosting Machine (GBM)
3.  Support Vector Machine with Radial Basis Function Kernel (SVM-RBF)
4.  Generalized Linear Model (GLM)
5.  Bagged CART (Tree Bag)
6.  Random Forest (RF)
7.  C5.0
8.  Linear Discriminant Analysis (LDA)
9.  Elastic Net (glmnet)
10. k-Nearest Neighbors (KNN)
11. Recursive Partitioning and Regression Trees (rpart)
12. Naive Bayes (NB)
13. Extreme Gradient Boosting (XGBoost)

## Performance Metrics

The package uses accuracy as the primary metric for model comparison.
However, it also provides confusion matrices for each model, allowing
for the calculation of additional metrics such as sensitivity,
specificity, and F1 score.

## Variable Importance

TCMC generates variable importance plots for each model,
offering insights into feature relevance across different algorithms.

## Limitations and Future Work

- Currently limited to binary classification problems
- Future versions will include support for multiclass classification and
  regression tasks
- Plans to incorporate more advanced hyperparameter tuning methods

## Citation

Below is the citation output from using `citation('TCMC')` in R. If you
use **TCMC** in your research, please cite it as follows:

``` r
print(citation("TCMC"), bibtex = TRUE)
#> To cite package 'TCMC' in publications use:
#> 
#>   Mukesha D (2024). _TCMC: Compare Classification Models_. R package
#>   version 0.99.0.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {TCMC: Compare Classification Models},
#>     author = {Dany Mukesha},
#>     year = {2024},
#>     note = {R package version 0.99.0},
#>   }
```
