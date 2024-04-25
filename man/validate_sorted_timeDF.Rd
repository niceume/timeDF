\name{validate_sorted_timeDF}
\alias{validate_sorted_timeDF}
\title{
  Checks whether the object is a valid sorted timeDF object
}
\description{
  Checks whether the object is a timeDF object sorted by its time information.
}
\usage{
validate_sorted_timeDF(timeDF, noerror=FALSE)
}
\details{
  validate_sorted_timeDF function checks whether the object is a timeDF
  object sorted by its time information. If noerror is FALSE and the
  object is not a valid sorted timeDF object, this function raises an
  error. If noerror is TRUE, this function returns FALSE when the object
  is not a valid sorted timeDF object.
}
\arguments{
  \item{timeDF}{timeDF object}
  \item{noerror}{boolean value determins whether the function raises an
    error or returns FALSE when the object is not a valid sorted timeDF
    object. }
}
\value{
  boolean
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
validate_sorted_timeDF(timeDF)
}
