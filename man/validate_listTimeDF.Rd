\name{validate_listTimeDF}
\alias{validate_listTimeDF}
\title{
  Checks whether the object is a list of timeDF objects
}
\description{
  Checks whether the object is list of timeDF objects
}
\usage{
validate_listTimeDF(listTimeDF, noerror=FALSE)
}
\details{
  validate_listTimeDF function checks whether the object is a list of
  timeDF objects. If noerror is FALSE and the object is not a list of
  timeDF objects, this function raises an error. If noerror is TRUE, this
  function returns FALSE when the object is not a list of timeDF objects.
}
\arguments{
  \item{listTimeDF}{is expected to be a list of timeDF objects}
  \item{noerror}{boolean value determins whether the function raises an
    error or returns FALSE when the object is not a valid timeDF
    object. }
}
\value{
  boolean
}
\seealso{
  \code{\link{timeDF-class}}
}
\examples{
time_df = as.timeDF(
    data.frame(
        time = c("2024-01-01 01:00:00",
                 "2024-02-02 02:00:00",
                 "2024-03-03 03:00:00",
                 "2024-04-04 04:00:00",
                 "2024-05-05 05:00:00"),
        value = c(123,
                  144,
                  150,
                  100,
                  180)
    ))
period_df = as.periodDF(
    data.frame(
        start = c(
            "2024-01-01",
            "2024-02-01",
            "2024-03-01",
            "2024-04-01",
            "2024-05-01"
        ),
        end = c(
            "2024-01-31",
            "2024-02-29",
            "2024-03-31",
            "2024-04-30",
            "2024-05-31"
        ),
        label = c(
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May"
        )
    ),
    period_type = "date",
    label_var = "label"
)
listTimeDF = extract_with_periodDF(time_df,
                                   period_df,
                                   include="both")
validate_listTimeDF(listTimeDF, noerror=TRUE)
}
