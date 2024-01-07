\name{flag_with_periodDF}
\alias{flag_with_periodDF}
\title{
Flag time records from timeDF object within periods of periodDF object
}
\description{
Flag time records of timeDF object that are included within periods
of periodDF object. Which time records are flagged follows the same rule
as \code{\link{extract_with_periodDF}} function.
}
\usage{
flag_with_periodDF(timeDF, periodDF, flag_var, include, modStart = 0,
modEnd = 0, units = NULL)
}
\arguments{
  \item{timeDF}{timeDF object}
  \item{periodDF}{periodDF object}
  \item{flag_var}{character element that specifies the column name to
    which flaggs are added}
  \item{include}{character element that specifies whether each end of
    periods is included or not}
  \item{modStart}{values to be added for starts of periods.}
  \item{modEnd}{values to be added for ends of periods.}
  \item{units}{units for values of modStart and modEnd}
}
\value{
  timeDF object flagged with labels
}
\seealso{
  \code{\link{timeDF-class}}
  \code{\link{periodDF-class}}
  \code{\link{timeDF-package}}
}
\examples{
time_df = data.frame(
    time = c("2023-01-01 12:00:00",
             "2023-01-21 12:00:00",
             "2023-02-10 12:00:00",
             "2023-03-02 12:00:00",
             "2023-03-22 12:00:00",
             "2023-04-11 12:00:00"
    ),
    value = c(123, 144, 150, 100, 130, 145)
)
timeDF = as.timeDF(time_df)

period_df = data.frame(
    start = c("2023-01-01",
              "2023-02-01",
              "2023-03-01"),
    end = c("2023-01-31",
            "2023-02-28",
            "2023-03-31"),
    label = c("Jan", "Feb", "Mar")
)
periodDF = as.periodDF(period_df, "date", label_var = "label")

flag_with_periodDF(timeDF, periodDF, "month_label", "both")
}
