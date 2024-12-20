% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/model_comparer.R
\name{model_comparer}
\alias{model_comparer}
\title{Compare Classification Models}
\format{
The most important input arguments needed are \code{data} and
\code{target_var}:
\describe{
\item{data}{contains 768 rows (observations) and 9 columns (features).}
\item{target_var}{column containing a binary vector where 1 indicates
diabetes patients and 0 for otherwise.}
}
}
\source{
\url{https://www.kaggle.com/uciml/pima-indians-diabetes-database}
}
\usage{
model_comparer(
  data,
  target_var,
  train_prop = 0.8,
  seed = 3456,
  for_utest = FALSE
)
}
\arguments{
\item{data}{A data frame containing the dataset to be used for modeling.}

\item{target_var}{The name of the target variable in the dataset.}

\item{train_prop}{The proportion of data to be used for training (default
is 0.8).}

\item{seed}{The random seed for reproducibility (default is 3456).}

\item{for_utest}{only for unit test when is TRUE (FALSE by default).}
}
\value{
A list containing the trained models and their performance metrics.
}
\description{
This function compares 13 different classification models using the caret
package.
}
\details{
This data set utilized in the example is originally from the National
Institute of Diabetes and Digestive and Kidney Diseases.
}
\examples{
library(mlbench)
data("PimaIndiansDiabetes", package = "mlbench", for_utest = FALSE)
# results <- model_comparer(PimaIndiansDiabetes, "diabetes")
}
\references{
Smith, J.W., Everhart, J.E., Dickson, W.C., Knowler, W.C.,
& Johannes, R.S. (1988). Using the ADAP learning algorithm to forecast
the onset of diabetes mellitus.
\emph{In Proceedings of the Symposium on Computer Applications and
Medical Care} (pp. 261--265). IEEE Computer Society Press.
}
\seealso{
\url{https://avehtari.github.io/modelselection/diabetes.html}
}
