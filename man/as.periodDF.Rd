\name{as.periodDF}
\alias{as.periodDF}
\title{
  Function to construct periodDF object from dataframe
}
\description{
  as.periodDF function interpret dataframe and convert it into
  periodDF class object.
}
\usage{
as.periodDF(df, period_type, format = "auto", start_var =
"start", end_var = "end", label_var = NULL)
}
\details{
    as.periodDF function constructs periodDF object from
dataframe. Types of periodDF are described in \code{\link{periodDF-class}}.
}
\arguments{
  \item{df}{dataframe that holds columns for starts and ends of periods
which are defined by start_var and end_var arguments. Column for labels
is optional.}
  \item{period_type}{character element that defines what kind of periods
are specified. "time", "date" or "time_in_a_day" is available.}
  \item{format}{character element that defines the formats of starts and
end columns. If "auto" is specified, format that corresponds to
period_type is automatically selected. If "as_is" is specified, columns
for start and end are used as they are without conversion. In this case,
column objects need to be compatible with objects that period_type
requires. Time requires POSIXlt or POSIXct with UTC timezone, date
requires Date, and time_in_a_day requires numeric values from 0 to 24 *
60 * 60. }
  \item{start_var}{character element that specifies the column name for
starts.}
  \item{end_var}{character element that specifies the column name for
ends.}
  \item{label_var}{character element that specifies the column name for
labels.}
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
as.periodDF(period_time, "time")

period_date = data.frame(
    start = c("2023-01-01",
              "2023-02-01",
              "2023-03-01"),
    end = c("2023-01-14",
            "2023-02-14",
            "2023-03-14"),
    label = c("Jan", "Feb", "Mar")
)
as.periodDF(period_date, "date")

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
as.periodDF( period_time_in_a_day,
             "time_in_a_day",
              label_var = "label")
}
