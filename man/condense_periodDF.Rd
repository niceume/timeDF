\name{condense_periodDF}
\alias{condense_periodDF}
\title{
  Function to condense periods in periodDF object
}
\description{
  condense_periodDF function 
}
\usage{
condense_periodDF(periodDF, open = TRUE, useData = "start")
}
\details{
  condense_periodDF function condenses periods in a periodDF object. If
  periods are overlapped, they are condensed into one period. When
  periods share the same timing with their start and end, whether they
  are combined into one period or are dealt separately depends on
  an argument of open.
}
\arguments{
  \item{periodDF}{S3 periodDF class}
  \item{open}{If this is set TRUE, periods are dealt as open
    intervals. If FALSE is set, periods are dealt as closed intervals.}
  \item{useData}{"start" or "end" is specified. This decides how columns
    other than start and end are combined. If "start" is specified, data
    of a period that contains start timing is used for the combined
    period. If "end" is specified, data of end period is used. 
    }
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
condense_periodDF(periodTime, open = TRUE)
condense_periodDF(periodTime, open = FALSE)

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
condense_periodDF(periodDate, open=TRUE)
condense_periodDF(periodDate, open=FALSE)

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
condense_periodDF( periodTimeInDay, open = TRUE)
condense_periodDF( periodTimeInDay, open = FALSE)
}
