summary.periodDF = function(object, ...){
    periodDF = object
    period_type = attr(periodDF, "period_type")
    start_var = attr(periodDF, "start_var")
    end_var = attr(periodDF, "end_var")
    label_var = attr(periodDF, "label_var")

    min_start = min(periodDF[[start_var]])
    max_start = max(periodDF[[start_var]])
    min_end = min(periodDF[[end_var]])
    max_end = max(periodDF[[end_var]])

    if( period_type == "time"){
        min_start_str = format(min_start, "%Y-%m-%d %H:%M:%S")
        max_start_str = format(max_start, "%Y-%m-%d %H:%M:%S")
        min_end_str = format(min_end, "%Y-%m-%d %H:%M:%S")
        max_end_str = format(max_end, "%Y-%m-%d %H:%M:%S")
    }else if(period_type == "date"){
        min_start_str = format(min_start, "%Y-%m-%d")
        max_start_str = format(max_start, "%Y-%m-%d")
        min_end_str = format(min_end, "%Y-%m-%d")
        max_end_str = format(max_end, "%Y-%m-%d")
    }else if(period_type == "time_in_a_day"){
        min_start_str = offset_to_time_in_a_day( min_start )
        max_start_str = offset_to_time_in_a_day( max_start )
        min_end_str = offset_to_time_in_a_day( min_end )
        max_end_str = offset_to_time_in_a_day( max_end )
    }

    result = list(
        "class" = "periodDF",
        "period_type" = period_type,
        "# of rows" = nrow(periodDF),
        "start_var" = start_var,
        "end_var" = end_var,
        "label_var" = label_var,
        "start range" = paste(min_start_str, max_start_str, sep=" - "),
        "end range" = paste(min_end_str, max_end_str, sep=" - ")
    )
    return( result )
}

offset_to_time_in_a_day = function(offset){
    hour = offset %/% 3600
    min_sec = offset %% 3600

    min = min_sec %/% 60
    sec = offset %% 60

    str = sprintf("%02d:%02d:%02d", hour, min, sec)
    return(str)
}
