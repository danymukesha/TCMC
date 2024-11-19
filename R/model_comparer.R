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
#' @param for_utest only for unit test when is TRUE (FALSE by default).
#'
#' @format The most important input arguments needed are \code{data} and
#' \code{target_var}:
#' \describe{
#'   \item{data}{contains 768 rows (observations) and 9 columns (features).}
#'   \item{target_var}{column containing a binary vector where 1 indicates
#'   diabetes patients and 0 for otherwise.}
#' }
#'
#' @return A list containing the trained models and their performance metrics.
#' @export
#'
#' @import tidyverse
#' @import mlbench
#' @importFrom caret createDataPartition trainControl train confusionMatrix
#' @import gbm
#' @import randomForest
#' @importFrom stats relevel as.formula predict
#' @import gbm
#' @import C50
#' @import klaR
#'
#' @details
#' This data set utilized in the example is originally from the National
#' Institute of Diabetes and Digestive and Kidney Diseases.
#'
#' @source \url{https://www.kaggle.com/uciml/pima-indians-diabetes-database}
#'
#' @seealso \url{https://avehtari.github.io/modelselection/diabetes.html}
#'
#' @references Smith, J.W., Everhart, J.E., Dickson, W.C., Knowler, W.C.,
#' & Johannes, R.S. (1988). Using the ADAP learning algorithm to forecast
#' the onset of diabetes mellitus.
#' \emph{In Proceedings of the Symposium on Computer Applications and
#' Medical Care} (pp. 261--265). IEEE Computer Society Press.
#'
#' @examples
#' library(mlbench)
#' data("PimaIndiansDiabetes", package = "mlbench", for_utest = FALSE)
#' # results <- model_comparer(PimaIndiansDiabetes, "diabetes")
model_comparer <- function(data, target_var, train_prop = 0.8, seed = 3456,
    for_utest = FALSE) {
    # set.seed(seed)
    data[[target_var]] <- relevel(data[[target_var]], ref = "pos")

    trainIndex <- createDataPartition(data[[target_var]],
        p = train_prop, list = FALSE, times = 1
    )

    df_Train <- data[trainIndex, ]
    df_Test <- data[-trainIndex, ]

    control <- trainControl(method = "repeatedcv", number = 10, repeats = 3)
    if (for_utest) {
        models <- c("lvq", "rf")
    } else {
        models <- c(
            "lvq", "gbm", "svmRadial", "glm", "treebag", "rf", "C5.0",
            "lda", "glmnet", "knn", "rpart", "nb", "xgbTree"
        )
    }
    trained_models <- list()
    for (model in models) {
        formula <- as.formula(paste(target_var, "~ ."))
        trained_models[[model]] <- train(formula,
            data = df_Train,
            method = model, metric = "Accuracy",
            trControl = control
        )
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
#' @importFrom caret varImp
#' @examples
#' library(mlbench)
#' data("PimaIndiansDiabetes", package = "mlbench")
#' # results <- model_comparer(PimaIndiansDiabetes, "diabetes",
#' #    for_utest = FALSE)
#' # plot_importance(results$trained_models$lvq, "LVQ")
plot_importance <- function(model, model_name) {
    importance <- varImp(model, scale = FALSE)
    plot(importance,
        main = paste("Variable Importance -", model_name, "Model")
    )
}
