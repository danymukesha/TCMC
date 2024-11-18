#' Compare Classification Models
#'
#' This function compares 13 different classification models using the caret 
#' package.
#'
#' @param data A data frame containing the dataset to be used for modeling.
#' @param target_var The name of the target variable in the dataset.
#' @param train_prop The proportion of data to be used for training (default 
#' is 0.8).
#' @param seed The random seed for reproducibility (default is 3456).
#'
#' @return A list containing the trained models and their performance metrics.
#' @export
#'
#' @import tidyverse
#' @import mlbench
#' @import caret
#' @import gbm
#'
#' @examples
#' library(mlbench)
#' data("PimaIndiansDiabetes", package = "mlbench")
#' results <- compare_models(PimaIndiansDiabetes, "diabetes")
compare_models <- function(data, target_var, train_prop = 0.8, seed = 3456) {
  set.seed(seed)
  data[[target_var]] <- relevel(data[[target_var]], ref = "pos")
  
  trainIndex <- createDataPartition(data[[target_var]], p = train_prop, 
                                    list = FALSE, times = 1)
  df_Train <- data[trainIndex,]
  df_Test <- data[-trainIndex,]
  
  control <- trainControl(method = "repeatedcv", number = 10, repeats = 3)
  
  models <- c("lvq", "gbm", "svmRadial", "glm", "treebag", "rf", "C5.0", "lda", 
              "glmnet", "knn", "rpart", "nb", "xgbTree")
  
  trained_models <- list()
  for (model in models) {
    formula <- as.formula(paste(target_var, "~ ."))
    trained_models[[model]] <- train(formula, data = df_Train, method = model, 
                                     metric = "Accuracy", trControl = control)
  }
  
  model_performance <- lapply(trained_models, function(model) {
    predictions <- predict(model, df_Test)
    confusionMatrix(df_Test[[target_var]], predictions)
  })
  
  list(trained_models = trained_models, performance = model_performance)
}

#' Plot Variable Importance
#'
#' This function plots the variable importance for a given model.
#'
#' @param model A trained model object.
#' @param model_name The name of the model (used for the plot title).
#'
#' @return A ggplot object showing variable importance.
#' @export
#'
#' @examples
#' data(PimaIndiansDiabetes)
#' results <- compare_models(PimaIndiansDiabetes, "diabetes")
#' plot_importance(results$trained_models$lvq, "LVQ")
plot_importance <- function(model, model_name) {
  importance <- varImp(model, scale = FALSE)
  plot(importance, main = paste("Variable Importance -", model_name, "Model"))
}