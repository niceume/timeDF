sort_timeDF = function(timeDF, decreasing = FALSE){
    if(! is(timeDF, "timeDF")){
        stop("timeDF argument needs to be timeDF class object")
    }
    time_vec = time_vec(timeDF)
    result = timeDF[order(time_vec, decreasing = decreasing),]
    return(result)
}
