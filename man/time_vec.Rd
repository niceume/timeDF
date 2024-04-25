\name{time_vec}
\alias{time_vec}
\alias{time_var}
\title{
  time vector and column name for times of timeDF
}
\description{
  Functions to obtain time vector and column name for times of timeDF
}
\usage{
time_vec(timeDF)

time_var(timeDF)
}
\details{
  \code{time_vec} function returns times in timeDF object.

  \code{time_var} function returns the column name for times in timeDF
  object, i.e. returns the value of time_var attribute.
}
\arguments{
  \item{timeDF}{timeDF object}
}
\value{
  For \code{time_vec}, a vector of time objects
  
  For \code{time_var}, a string of the column name for tiems
}
\seealso{
  \code{\link{timeDF-class}}
}
\examples{
\dontshow{
    time_df = data.frame(
        time = c("2023-12-01 01:00:00",
                 "2023-12-01 02:00:00",
                 "2023-12-01 03:00:00",
                 "2023-12-02 04:00:00"),
        value = c(123,
                  144,
                  150,
                  100)
    )
    timeDF = as.timeDF(time_df)
}
time_vec(timeDF)
time_var(timeDF)
}
