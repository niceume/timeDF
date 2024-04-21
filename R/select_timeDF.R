select_timeDF = function(timeDF, colnames){
    if(! is(timeDF, "timeDF")){
        stop("timeDF argument needs to be timeDF class object")
    }
    if(any(! colnames %in% names(timeDF))){
        stop("unknown colnum names specified")
    }

    time_var = time_var(timeDF)
    time_vec = time_vec(timeDF)

    selected = timeDF[colnames]
    selected[[time_var]] = time_vec

    selected = as.timeDF(selected,
                         time_var = time_var,
                         format = "as_is")
    return(selected)
}
