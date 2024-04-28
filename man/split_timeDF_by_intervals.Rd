\name{split_timeDF_by_intervals}
\alias{split_timeDF_by_intervals}
\title{
  Function to split timeDF into a list by regular intervals
}
\description{
  split_timeDF_by_intervals splits timeDF into a list of timeDF objects
  by regular intervals. Intervals can be spcified by numeric value and
  its unit. For example, if the interval is specified as two days,
  timeDF object is split by two day interval. The start time for this
  interval is decided by the minimum time and the interval unit in the
  original timeDF. If there are no records present for some intervals,
  their corresponding results are timeDF objects with zero rows.
}
\usage{
split_timeDF_by_intervals(timeDF,byN,byUnits,
                          modStart=0,modEnd=0,modUnits = "auto")
}
\arguments{
  \item{timeDF}{timeDF object}
  \item{byN}{interval value, numeric}
  \item{byUnits}{interval unit, "days", "hours" or "mins"}
  \item{modStart}{values to be added for starts of intervals}
  \item{modEnd}{values to be added for ends of intervals}
  \item{modUnits}{units for values of modStart and modEnd}
}
\value{
  list of timeDF objects
}
\seealso{
  \code{\link{timeDF-class}}
}
\examples{
time_df = data.frame(
    time = c("2023-01-01 08:00:00",
             "2023-01-01 12:00:00",
             "2023-01-01 16:00:00",
             "2023-01-02 08:00:00",
             "2023-02-02 10:00:00",
             "2023-03-03 11:00:00",
             "2023-03-03 16:00:00",
             "2023-03-05 12:00:00"
    ),
    value = c(123, 144, 150, 100,
              130, 145, 180, 100)
)
timeDF = as.timeDF(time_df)

split_timeDF_by_intervals(timeDF, 1, "days")
}
