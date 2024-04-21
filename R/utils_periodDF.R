period_type = function(periodDF){
    if( ! "periodDF" %in% class(periodDF) ){
        stop("periodDF argument requires periodDF object")
    }
    period_type = attr(periodDF, "period_type")
    return(period_type)
}
