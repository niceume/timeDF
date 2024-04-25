\name{period_type}
\alias{period_type}
\title{
  Function to obtain period type of periodDF object
}
\description{
  period_type function returns the period type of periodDF object.
}
\usage{
period_type(periodDF)
}
\details{
  period_type function returns the period type of periodDF object.
}
\arguments{
  \item{periodDF}{periodDF object}
}
\value{
  string
}
\seealso{
  \code{\link{periodDF-class}}
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
period_type(periodTime)

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
periodDate = as.periodDF(period_date, "date",
label_var = "label")
period_type(periodDate)

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
periodTimeInDay = as.periodDF(period_time_in_a_day,
"time_in_a_day", label_var = "label")
period_type(periodTimeInDay)
}
