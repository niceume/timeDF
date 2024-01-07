\name{sort_periodDF}
\alias{sort_periodDF}
\title{
  Function to sort periods in  periodDF object
}
\description{
  sort_periodDF function 
}
\usage{
sort_periodDF(periodDF, by="start")
}
\details{
  sort_periodDF function sort periods in a periodDF object.
}
\arguments{
  \item{periodDF}{S3 periodDF class}
  \item{by}{"start" or "end" is set. Periods are sorted by start_var or
    end_var in periodDF.}
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
     start = c("2023-12-01 01:00:00",
               "2023-12-01 02:00:00",
               "2023-12-01 03:00:00",
               "2023-12-02 04:00:00"),
     end = c("2023-12-01 02:00:00",
             "2023-12-01 03:00:00",
             "2023-12-01 04:00:00",
             "2023-12-02 05:00:00")
)
periodTime = as.periodDF(period_time, "time")
sort_periodDF(periodTime)

period_date = data.frame(
    start = c("2023-01-01",
              "2023-01-14",
              "2023-02-14",
              "2023-03-14"),
    end = c("2023-01-31",
            "2023-02-14",
            "2023-03-14",
            "2023-04-14"),
    label = c("One", "Two", "Three", "Four")
)
periodDate = as.periodDF(period_date, "date")
sort_periodDF(periodDate)

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
sort_periodDF(periodTimeInDay)
}
