\name{summary.timeDF}
\alias{summary.timeDF}
\title{
  Summarize timeDF S3 object
}
\description{
  summary function for timeDF S3 object.
}
\usage{
\method{summary}{timeDF}(object,\dots)
}
\details{
  summary function for timeDF S3 object. This enables users to obtain the
  summary of periods.
}
\arguments{
  \item{object}{S3 timeDF class}
  \item{...}{Further arguments passed to or from other methods.}
}
\value{
  List that have properties of timeDF object.
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
summary(timeDF)
}
