\name{vec_to_periodDF}
\alias{vec_to_periodDF}
\title{
  Function to construct periodDF object from vector
}
\description{
  vec_to_periodDF function takes a vector of timepoints or dates
  to start and each duration, and constructs periodDF class object.
}
\usage{
vec_to_periodDF(vec, period_type, duration, units, format = "auto",
labels = NULL, pre_margin = 0)
}
\details{
vec_to_periodDF function takes a vector of timepoints or dates to
start and each duration, and constructs periodDF class object. Types of
periodDF are described in \code{\link{periodDF-class}}.
}
\arguments{
  \item{vec}{vector that represents starts of periods. If pre_margin
    argument is specified, each period extends forward from the starts.}
  \item{period_type}{character element that defines what kind of periods are
    specified. "time", "date" or "time_in_a_day" is available.}
  \item{duration}{numeric values represent duration of each period.}
  \item{units}{character element represents unit of duration.}
  \item{labels}{labels that are used for each period.}
  \item{format}{character element that defines the formats of vec. If
    "auto" is specified, format that corresponds to period_type is
    automatically selected. If "as_is" is specified, the vector is used
    for starts of periods as it is without conversion. In this case, the
    vector needs to be compatible with objects that period_type
    requires. Time requires POSIXlt or POSIXct with UTC timezone, date
    requires Date, and time_in_a_day requires numeric values from 0 to
    24 * 60 * 60. }
  \item{pre_margin}{numeric values; if values are set, each period
    extends forward from the starts specified in vec argument. }
}
\value{
  periodDF object
}
\seealso{
  \code{\link{periodDF-class}}
  \code{\link{timeDF-package}}
}
\examples{
start_time = c("2023-12-01 01:00:00",
               "2023-12-02 02:00:00",
               "2023-12-03 03:00:00",
               "2023-12-04 04:00:00")
vec_to_periodDF(start_time, "time", 1, "hours")

start_date = c("2023-01-01",
               "2023-02-01",
               "2023-03-01")
vec_to_periodDF(start_date, "date", 14, "days",
                      labels = c("Jan", "Feb", "Mar"))

start_time_in_a_day = c("06:00",
                        "11:00",
                        "18:00")
vec_to_periodDF(start_time_in_a_day, "time_in_a_day",
                      4, "hours",
                      labels = c("morning", "afternoon", "evening"))
}
