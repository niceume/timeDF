as.data.frame.timeDF = function( x, row.names = NULL, optional = FALSE,
                                 format = "%Y-%m-%d %H:%M:%S", ...){
    timeDF = x
    if( ! "timeDF" %in% class(timeDF) ){
        stop("timeDF argument requires timeDF object")
    }

    if(length(attr(timeDF, "class")) == 1){
        attr(timeDF, "class") = NULL
    }else{
        class_vec = attr(timeDF, "class")
        attr(timeDF, "class") = (class_vec[! class_vec == "timeDF"])
    }

    time_var = attr(timeDF, "time_var")
    time_str = format(timeDF[[time_var]], format)
    timeDF[[time_var]] = time_str
    attr(timeDF, "time_var") = NULL

    return(as.data.frame(timeDF, row.names, optional, ...))
}
