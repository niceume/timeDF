\name{listTimeDF_to_timeDF}
\alias{listTimeDF_to_timeDF}
\title{
  converts a list of timeDF objects into a timeDF object
}
\description{
  listTimeDF_to_timeDF function combines timeDF objects in the original
  list. Each timeDF name in the original list is assigned to a column
  specified by name_var argument.
}
\usage{
listTimeDF_to_timeDF(listTimeDF, name_var = "name")
}
\arguments{
  \item{listTimeDF}{a list of timeDF objects}
  \item{name_var}{column name holding names from the original list}
}
\value{
  timeDF object
}
\seealso{
  \code{\link{timeDF-class}}
}
\examples{
  \dontshow{
    time_df = as.timeDF(
        data.frame(
            time = c("2024-01-01 01:00:00",
                     "2024-02-02 02:00:00",
                     "2024-03-03 03:00:00",
                     "2024-04-04 04:00:00",
                     "2024-05-05 05:00:00"),
            value = c(123,
                      144,
                      150,
                      100,
                      180)
        ))
    period_df = as.periodDF(
        data.frame(
            start = c(
                "2024-01-01",
                "2024-02-01",
                "2024-03-01",
                "2024-04-01",
                "2024-05-01"
            ),
            end = c(
                "2024-01-31",
                "2024-02-29",
                "2024-03-31",
                "2024-04-30",
                "2024-05-31"
            ),
            label = c(
                "Jan",
                "Feb",
                "Mar",
                "Apr",
                "May"
            )
        ),
        period_type = "date",
        label_var = "label"
        )
    }
    listTimeDF = extract_with_periodDF(
                     time_df,
                     period_df,
                     include="both")
    listTimeDF_to_timeDF(listTimeDF)
}
