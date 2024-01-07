%File timeDF-package.Rd
\name{timeDF-package}
\alias{timeDF-package}
\alias{timeDF}
\docType{package}
\title{
\packageTitle{timeDF}
}
\description{
\packageDescription{timeDF}
}
\details{
  Package timeDF provides functionality to deal with times with the use
  of periods. With period information, data frames with time information
  are subset and flagged.
}
\author{
\packageAuthor{timeDF}
Maintainer: \packageMaintainer{timeDF}
}
\keyword{ package }
\seealso{
  \code{\link{timeDF-class}}
  \code{\link{periodDF-class}}
  \code{\link{as.timeDF}}
  \code{\link{as.periodDF}}
  \code{\link{vec_to_periodDF}}
  \code{\link{extract_with_periodDF}}
  \code{\link{flag_with_periodDF}}
}
\examples{
library(timeDF)
time_df = data.frame(
    time = c("2023-01-01 12:00:00",
             "2023-01-21 12:00:00",
             "2023-02-10 12:00:00",
             "2023-03-02 12:00:00",
             "2023-03-22 12:00:00",
             "2023-04-11 12:00:00"
    ),
    value = c(123, 144, 150, 100, 130, 145)
)

timeDF = as.timeDF(time_df)

period_df = data.frame(
    start = c("2023-01-01",
              "2023-03-01"),
    end = c("2023-01-31",
            "2023-03-31")
)
periodDF = as.periodDF(period_df, "date")

extract_with_periodDF(timeDF, periodDF, "both")
}
