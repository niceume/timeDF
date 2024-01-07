\name{extract_with_periodDF}
\alias{extract_with_periodDF}
\title{
Extract time records from timeDF object within periods of periodDF object
}
\description{
Extract time records from timeDF object that are included within periods
of periodDF object. periodDF object has one of some timescales, and how
this function extracts time records depends on the timescale. Also, when
the time is on either end of a time period, whether the time record is
extracted or not depends on the include argument. "both" means including
both sides, "right" means including only the right side, "left" means
including only the left side, and "none" does not include any sides.
}
\usage{
extract_with_periodDF(timeDF, periodDF, include, modStart = 0, modEnd = 0,
units = NULL, outputAsBool = FALSE)
}
\arguments{
  \item{timeDF}{timeDF object}
  \item{periodDF}{periodDF object}
  \item{include}{character element that specifies whether each end of
    periods is included or not}
  \item{modStart}{values to be added for starts of periods.}
  \item{modEnd}{values to be added for ends of periods.}
  \item{units}{units for values of modStart and modEnd}
  \item{outputAsBool}{boolean value; if this is TRUE, the return value is
    a boolean vector or boolean vectors that represent(s) records to be
    extracted}
}
\value{
  If periodDF does not have labels, timeDF object or a boolean object is
  returned. If periodDF has labels, a list of timeDF objects with keys
  of label names or a list of boolean vectors with label name keys is retruned.
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

extract_with_periodDF(timeDF, periodDF, "both")
}
