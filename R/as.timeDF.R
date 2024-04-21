as.timeDF = function(df, time_var = "time", format = "%Y-%m-%d %H:%M:%S" ){
    if(is.null(df[[time_var]])){
        stop(paste("df requires column of", time_var))
    }
    time_vec = df[[time_var]]

    if(format == "as_is"){
        confirm_time_object(time_vec)
        if(! "UTC" %in% attr(time_vec, "tzone")){
            stop("column for time needs to have UTC timezones")
        }
        result_time_vec = time_vec
    }else{
        result_time_vec = strptime( time_vec, format, tz = "UTC")
    }
    df[[time_var]] = result_time_vec
    if( ! "timeDF" %in% attr(df, "class")){
        attr(df, "class") = c("timeDF", attr(df, "class"))
    }
    attr(df, "time_var") = time_var
    return( df )
}
