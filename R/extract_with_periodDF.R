extract_with_periodDF = function(timeDF, periodDF, include,
                                 modStart = 0, modEnd = 0, units = NULL,
                                 outputAsBool = FALSE){
    if( ! "timeDF" %in% class(timeDF) ){
        stop("timeDF argument requires timeDF object")
    }
    if( ! "periodDF" %in% class(periodDF) ){
        stop("periodDF argument requires periodDF object")
    }

    period_type = attr(periodDF, "period_type")
    if( is.null(attr(periodDF, "label_var")) ){
        if( period_type == "time"){
            result_bool = examine_with_time_periods(timeDF, periodDF, include, modStart, modEnd, units)
        }else if(period_type == "date"){
            result_bool = examine_with_date_periods(timeDF, periodDF, include, modStart, modEnd, units)
        }else if(period_type == "time_in_a_day"){
            result_bool = examine_with_time_periods_within_a_day(timeDF, periodDF, include, modStart, modEnd, units)
        }
        if(outputAsBool){
            result = result_bool
        }else{
            result = timeDF[result_bool,]
        }
    }else{
        start_vec = periodDF[[attr(periodDF, "start_var")]]
        end_vec = periodDF[[attr(periodDF, "end_var")]]
        label_vec = periodDF[[attr(periodDF, "label_var")]]
        if( period_type == "time"){
            result_bool_list = examine_with_time_periods(timeDF, periodDF, include, modStart, modEnd, units)
        }else if(period_type == "date"){
            result_bool_list = examine_with_date_periods(timeDF, periodDF, include, modStart, modEnd, units)
        }else if(period_type == "time_in_a_day"){
            result_bool_list = examine_with_time_periods_within_a_day(timeDF, periodDF, include, modStart, modEnd, units)
        }
        if(outputAsBool){
            result = result_bool_list
        }else{
            result = list()
            n_result = length(result_bool_list)
            for( i in seq(1, n_result)){
                label = label_vec[i]
                result[[label]] = timeDF[result_bool_list[[label]], ]
            }
        }
    }
    return(result)
}
