\name{select_timeDF}
\alias{select_timeDF}
\title{
  Function to select columns in timeDF object
}
\description{
  select_timeDF function 
}
\usage{
select_timeDF(timeDF, colnames)
}
\details{
  select_timeDF function returns a new timeDF object with columns
  specified and the column holding time information.
}
\arguments{
  \item{timeDF}{timeDF object}
  \item{colnames}{column names to be selected, chracter vector}
}
\value{
  timeDF object
}
\seealso{
  \code{\link{timeDF-class}}
}
\examples{
time_df = data.frame(
    time = c("2023-12-01 01:00:00",
             "2023-12-01 05:00:00",
             "2023-12-01 09:00:00",
             "2023-12-01 13:00:00",
             "2023-12-01 17:00:00",
             "2023-12-01 21:00:00"),
    value = c(123,
              144,
              150,
              100,
              200,
              180),
    phase = c("A",
              "A",
              "B",
              "B",
              "C",
              "C")
)
timeDF = as.timeDF(time_df)
select_timeDF(timeDF, c("phase"))
}
