\name{convert_periodDF}
\alias{convert_periodDF}
\title{
  Function to convert type of periodDF object
}
\description{
  convert_periodDF function 
}
\usage{
convert_periodDF(periodDF, period_type, base_date = NULL)
}
\details{
  convert_periodDF function converts period types of periodDF
  object. Conversions from "date" to "time", "time" to "date", "time" to
  "time_in_a_day" and "time_in_a_day" to "time" are supported.}
\arguments{
  \item{periodDF}{S3 periodDF class}
  \item{period_type}{period_type to be conveted to}
  \item{base_date}{only used when converting time_in_a_day into time type}
}
\value{
  periodDF object
}
\seealso{
  \code{\link{periodDF-class}}
  \code{\link{timeDF-package}}
}
\examples{
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
convert_periodDF(periodDate, "time")

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
convert_periodDF(periodTime, "date")

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
convert_periodDF( periodTimeInDay, "time", base_date = "2023-12-01")
}
