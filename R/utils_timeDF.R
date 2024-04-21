time_vec = function(timeDF){
    if(! is(timeDF, "timeDF")){
        stop("timeDF argument needs to be timeDF class object")
    }
    time_var = time_var(timeDF)
    return(timeDF[[time_var]])
}

time_var = function(timeDF){
    if(! is(timeDF, "timeDF")){
        stop("timeDF argument needs to be timeDF class object")
    }
    return(attr(timeDF, "time_var"))
}
