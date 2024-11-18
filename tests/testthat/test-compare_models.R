library(testthat)
library(mlbench)
library(caret)


test_that("model_comparer executes successfully and returns expected 
          structure", {
    data("PimaIndiansDiabetes", package = "mlbench")
    
    results <- model_comparer(PimaIndiansDiabetes, "diabetes", 
                              train_prop = 0.8, seed = 3456, for_utest = TRUE)
    expect_type(results, "list")
    expect_named(results, c("trained_models", "performance"))
    expect_length(results$trained_models, 2) # for test
    expect_s3_class(results$trained_models$lvq, "train") 
    expect_s3_class(results$performance[[1]], "confusionMatrix") 
})

test_that("plot_importance executes successfully and returns a plot", {
    data("PimaIndiansDiabetes", package = "mlbench")
    
    results <- model_comparer(PimaIndiansDiabetes, "diabetes", 
                              train_prop = 0.8, seed = 3456, for_utest = TRUE)
    model <- results$trained_models$lvq
    
    expect_silent({
        plot_importance(model, "LVQ")
    })
})