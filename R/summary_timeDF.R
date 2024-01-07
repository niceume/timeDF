summary.timeDF = function(object, ...){
    timeDF = object
    time_var = attr(timeDF, "time_var")
    time_vec = timeDF[[time_var]]

    result = list(
        "class" = "timeDF",
        "# of rows" = nrow(timeDF),
        "time_var" = attr(timeDF, "time_var"),
        "time range" = paste(
            format( min(time_vec), "%Y-%m-%d %H:%M:%S"),
            format( max(time_vec), "%Y-%m-%d %H:%M:%S"),
            sep = " - "
        )
    )
    return( result )
}
