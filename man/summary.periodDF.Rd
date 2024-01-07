\name{summary.periodDF}
\alias{summary.periodDF}
\title{
  Summarize periodDF S3 object
}
\description{
  summary function for periodDF S3 object.
}
\usage{
\method{summary}{periodDF}(object,\dots)
}
\details{
  summary function for periodDF S3 object. This enables users to obtain the
  summary of periods.
}
\arguments{
  \item{object}{S3 periodDF class}
  \item{...}{Further arguments passed to or from other methods.}
}
\value{
  List that have properties of periodDF object.
}
\seealso{
  \code{\link{periodDF-class}}
}
\examples{
\dontshow{
    period_time = data.frame(
        start = c("2023-12-01 01:00:00",
                 "2023-12-01 02:00:00",
                 "2023-12-01 03:00:00",
                 "2023-12-02 04:00:00"),
        end = c("2023-12-01 01:00:00",
                 "2023-12-01 02:00:00",
                 "2023-12-01 03:00:00",
                 "2023-12-02 04:00:00")
    )
    periodDF = as.periodDF(period_time, "time")
}
summary(periodDF)
}
