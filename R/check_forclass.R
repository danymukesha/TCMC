#' Check Classification Models
#'
#' This function verifies if the given machine learning models support
#' classification tasks by ensuring the `forClass` column is `TRUE`
#' in their model lookup details.
#'
#' @param models A character vector of model names to check.
#' @return A data frame containing model details where `forClass` is `TRUE`.
#' @examples
#' check_forclass(c("lvq", "gbm", "svmRadial"))
#' @import caret
#' @export
check_forclass <- function(models) {
    if (!requireNamespace("caret", quietly = TRUE)) {
        stop("The 'caret' package is required but not installed.
            Please install it.")
    }
    # names(getModelInfo())

    results <- lapply(models, function(model) {
        lookup <- caret::modelLookup(model)
        lookup[lookup$forClass == TRUE, ]
    })

    do.call(rbind, results)
}
