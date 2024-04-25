\name{sort_timeDF}
\alias{sort_timeDF}
\title{
  Function to sort records in timeDF object
}
\description{
  sort_timeDF function 
}
\usage{
sort_timeDF(timeDF, decreasing=FALSE)
}
\details{
  sort_timeDF function sorts records in timeDF object.
}
\arguments{
  \item{timeDF}{timeDF object}
  \item{decreasing}{boolean value to specify whether the sorting is
    conducted in decreasing order or not.}
}
\value{
  timeDF object
}
\seealso{
  \code{\link{timeDF-class}}
}
\examples{
\dontshow{
    time_df = data.frame(
        time = c("2023-12-01 04:00:00",
                 "2023-12-01 03:00:00",
                 "2023-12-01 02:00:00",
                 "2023-12-02 01:00:00"),
        value = c(123,
                  144,
                  150,
                  100)
    )
    timeDF = as.timeDF(time_df)
}
sort_timeDF(timeDF)
}
