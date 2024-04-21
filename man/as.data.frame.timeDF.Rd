\name{as.data.frame.timeDF}
\alias{as.data.frame.timeDF}
\title{
  Convert timeDF object to a plain dataframe
}
\description{
  Convert timeDF object to a plain dataframe.
}
\usage{
\method{as.data.frame}{timeDF}(x,row.names=NULL,optional=FALSE,format =
"\%Y-\%m-\%d \%H:\%M:\%S",\dots)
}
\details{
  Convert timeDF object to a plain dataframe.
}
\arguments{
  \item{x}{timeDF object}
  \item{row.names}{same as as.data.frame in base}
  \item{optional}{same as as.data.frame in base}
  \item{format}{character element that describes how times in timeDF are
  converted to chracters. If "as_is" is specified, time objects are not
  preserved without converting to characters.}
  \item{...}{Further arguments passed to or from other methods}
}
\value{
  dataframe
}
\seealso{
  \code{\link{timeDF-class}}
  \code{\link{timeDF-package}}
}
\examples{
\dontshow{
    time_df = data.frame(
        time = c("2023-12-01 01:00:00",
                 "2023-12-01 02:00:00",
                 "2023-12-01 03:00:00",
                 "2023-12-02 04:00:00"),
        value = c(123,
                  144,
                  150,
                  100)
    )
    timeDF = as.timeDF(time_df)
}
as.data.frame(timeDF)
}
