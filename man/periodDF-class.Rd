\name{periodDF-class}
\alias{periodDF-class}
\alias{periodDF}
\title{
periodDF S3 class
}
\description{
periodDF object stores definitions of periods.
}
\details{
  periodDF object stores definitions of periods and the periods can be
  defined in one of some timescales, "time", "date" or
  "time_in_a_day". If "time" is specified, each period means period
  between two timepoints. If "date" is specified, each period represents
  period between two dates. If "time_in_a_day" is used, each period
  means period between two timepoints in a day. periodDF object is used
  with functions in \code{\link{timeDF-package}}, and those functions
  behave diffrently based on the timescale.
}
\seealso{
  \code{\link{as.periodDF}}
  \code{\link{vec_to_periodDF}}
  \code{\link{timeDF-package}}
}
