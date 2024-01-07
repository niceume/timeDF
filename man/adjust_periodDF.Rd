\name{adjust_periodDF}
\alias{adjust_periodDF}
\title{
  Function to adjust starts and ends for periods in periodDF object
}
\description{
  adjust_periodDF function 
}
\usage{
adjust_periodDF(periodDF, adjStart, adjEnd, units)
}
\details{
  adjust_periodDF function adjust starts and ends for periods in
  periodDF objects.}
\arguments{
  \item{periodDF}{S3 periodDF class}
  \item{adjStart}{values to be added for starts.}
  \item{adjEnd}{values to be added for ends.}
  \item{units}{units for values of adjStart and adjEnd}
}
\value{
  periodDF object
}
\seealso{
  \code{\link{periodDF-class}}
  \code{\link{timeDF-package}}
}
\examples{
period_time = data.frame(
     start = c("2023-12-01 03:00:00",
               "2023-12-01 20:00:00",
               "2023-12-02 05:00:00",
               "2023-12-03 21:00:00"),
     end = c("2023-12-01 04:00:00",
             "2023-12-01 21:00:00",
             "2023-12-02 06:00:00",
             "2023-12-03 22:00:00")
)
periodTime = as.periodDF(period_time, "time")
adjust_periodDF(periodTime, -1, 3, units="hours")

period_date = data.frame(
    start = c("2023-01-01",
              "2023-02-01",
              "2023-03-01",
              "2023-04-01"),
    end = c("2023-01-14",
            "2023-02-14",
            "2023-03-14",
            "2023-04-14"),
    label = c("One", "Two", "Three", "Four")
)
periodDate = as.periodDF(period_date, "date")
adjust_periodDF(periodDate, -1, 1, units="days")

period_time_in_a_day = data.frame(
    start = c("04:00",
              "11:00",
              "17:00"),
    end = c("11:00",
            "17:00",
            "24:00"),
    label = c("morning",
              "afternoon",
              "evening")
)
periodTimeInDay = as.periodDF(period_time_in_a_day, "time_in_a_day", label_var = "label")
adjust_periodDF( periodTimeInDay, 1, 1, "hours")
}
