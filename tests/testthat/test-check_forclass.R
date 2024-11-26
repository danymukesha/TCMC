library(testthat)

test_that("check_forclass filters correctly", {
    models <- c("lvq", "gbm", "svmRadial")
    result <- check_forclass(models)
    expect_s3_class(result, "data.frame")
    expect_true(all(c(
        "model", "parameter", "label", "forReg", "forClass",
        "probModel"
    ) %in% colnames(result)))
    expect_true(all(result$forClass == TRUE))

    expect_true("lvq" %in% result$model)
    expect_true("gbm" %in% result$model)
    expect_true("svmRadial" %in% result$model)
})
