adjust_periodDF = function(periodDF, adjStart, adjEnd, units){
    if( ! "periodDF" %in% class(periodDF) ){
        stop("periodDF argument requires periodDF object")
    }

    start_var = attr(periodDF, "start_var")
    end_var = attr(periodDF, "end_var")
    label_var = attr(periodDF, "label_var")
    start_vec = periodDF[[start_var]]
    end_vec = periodDF[[end_var]]
    period_type = attr(periodDF, "period_type")

    if(period_type == "time" || period_type == "date"){
        if(period_type == "date"){
            if(! units %in% c("days")){
                stop('only "days" can be specified for units argument for date type')
            }
        }
        result = periodDF
        new_start_vec = start_vec + as.difftime(adjStart, units= units)
        new_end_vec = end_vec + as.difftime(adjEnd, units= units)
        if(any(new_start_vec > new_end_vec)){
            stop("start(s) larger than end(s) is(are) found")
        }
        result[[start_var]] = new_start_vec
        result[[end_var]] = new_end_vec
    }else if(period_type == "time_in_a_day"){
#        if(units == "hours"){
#            offset1 = adjStart * 60 * 60
#            offset2 = adjEnd * 60 * 60
#        }else if(units == "mins"){
#            offset1 = adjStart * 60
#            offset2 = adjEnd * 60
#        }else if(units == "secs"){
#            offset1 = adjStart
#            offset2 = adjEnd
        if(units %in% c("hours", "mins", "secs")){
            offset1 = convert_to_seconds(adjStart, unitsFrom = units)
            offset2 = convert_to_seconds(adjEnd, unitsFrom = units)
        }else{
            stop('"hours", "mins" or "secs" can be specified for units argument for time_in_a_day type')
        }
        if(any(abs(offset1) >= 24 * 60 * 60) ||
           any(abs(offset2) >= 24 * 60 * 60)){
            stop("modification size is too large")
        }
        new_start_vec = start_vec + offset1
        new_end_vec = end_vec + offset2
        if(any(new_start_vec > new_end_vec)){
            stop("start(s) larger than end(s) is(are) found")
        }
        if(any((new_start_vec - new_end_vec) >= 24 * 60 * 60)){
            stop("period(s) is(are) too large")
        }

        result = data.frame()
        for( i in seq(1, nrow(periodDF))){
            period = periodDF[i,]
            period[[start_var]] = new_start_vec[i]
            period[[end_var]] = new_end_vec[i]
            if(period[[start_var]] < 0){
                period1 = period
                period2 = period
                period1[[start_var]] = period1[[start_var]] + 24 * 60 * 60
                period1[[end_var]] = 24 * 60 * 60
                period2[[start_var]] = 0
                result = rbind(result, period1)
                result = rbind(result, period2)
            }else if(period[[end_var]] > 24 * 60 * 60){
                period1 = period
                period2 = period
                period1[[end_var]] = 24 * 60 * 60
                period2[[start_var]] = 0
                period2[[end_var]] = period2[[end_var]] - 24 * 60 * 60
                result = rbind(result, period1)
                result = rbind(result, period2)
            }else{
                result = rbind(result, period)
            }
        }
        result = as.periodDF(result, period_type = "time_in_a_day",
                             format = "as_is",
                             start_var = start_var,
                             end_var = end_var,
                             label_var = label_var)
    }
    return(result)
}
