convert_periodDF = function(periodDF, period_type, base_date = NULL){
    if( ! "periodDF" %in% class(periodDF) ){
        stop("periodDF argument requires periodDF object")
    }

    start_var = attr(periodDF, "start_var")
    end_var = attr(periodDF, "end_var")
    start_vec = periodDF[[start_var]]
    end_vec = periodDF[[end_var]]
    ori_type = attr(periodDF, "period_type")
    new_type = period_type
    result = periodDF

    if(ori_type == "date" && new_type == "time"){
        result[[start_var]] = strptime( paste( format(start_vec, "%Y-%m-%d"),"00:00:00" ,sep = " "), "%Y-%m-%d %H:%M:%S", tz = "UTC")
        result[[end_var]] = strptime( paste( format(end_vec, "%Y-%m-%d"),"24:00:00" ,sep = " "), "%Y-%m-%d %H:%M:%S", tz = "UTC")
        attr(result, "period_type") = new_type
    }else if(ori_type == "time" && new_type == "date"){
        result[[start_var]] = as.Date(format(start_vec, "%Y-%m-%d"))
        result[[end_var]] = as.Date(format(end_vec, "%Y-%m-%d"))
        attr(result, "period_type") = new_type
    }else if(ori_type == "time" && new_type == "time_in_a_day"){
        diff_secs = as.numeric( difftime(end_vec, start_vec, units = "secs"))
        if( any(diff_secs >= 24 * 60 * 60) ){
            stop("period(s) is(are) too large to convert")
        }
        start_offset = convert_time_in_a_day_to_time_offset( format(start_vec, "%H:%M:%S") )
        result[[start_var]] = start_offset
        result[[end_var]] = start_offset # This is intentional. adjust_periodDF is safe.
        attr(result, "period_type") = new_type
        result = adjust_periodDF(result, 0, diff_secs, "secs")
    }else if(ori_type == "time_in_a_day" && new_type == "time"){
        if( is.null(base_date) ){
            stop("base_date argument is required to convert from time_in_a_day to time")
        }
        base_time = strptime(paste(format(as.Date(base_date), "%Y-%m-%d"),"00:00:00" ,sep = " "), "%Y-%m-%d %H:%M:%S", tz = "UTC")
        result[[start_var]] = base_time + start_vec
        result[[end_var]] = base_time + end_vec
        attr(result, "period_type") = new_type
    }else{
        stop(paste("conversion from", ori_type, "to", new_type, "is not supported", sep=" "))
    }

    return(result)
}
