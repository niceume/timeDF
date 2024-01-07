\name{as.timeDF}
\alias{as.timeDF}
\title{
  Function to construct timeDF object from dataframe
}
\description{
  as.timeDF function converts dataframe into timeDF class object
}
\usage{
as.timeDF(df, time_var = "time", format = "\%Y-\%m-\%d \%H:\%M:\%S")
}
\details{
    as.timeDF function constructs timeDF object from dataframe.
}
\arguments{
  \item{df}{dataframe that holds a column for time as character.}
  \item{time_var}{character element that specifies column name for time
    in the dataframe.}
  \item{format}{character element that specifies a format for times. If
    "as_is" is specified, column for start is used as it is without
    conversion. In this case, column needs to be POSIXlt with UTC timezone.}
}
\value{
  timeDF object
}
\seealso{
  \code{\link{timeDF-class}}
  \code{\link{timeDF-package}}
}
\examples{
time_df = data.frame(
    time = c("2023-12-01 01:00:00",
             "2023-12-01 02:00:00",
             "2023-12-01 03:00:00",
             "2023-12-01 04:00:00"),
    value = c(123,
              144,
              150,
              100)
)
as.timeDF(time_df)
}
