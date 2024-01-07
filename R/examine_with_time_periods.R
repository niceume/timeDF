examine_with_time_periods = function( timeDF, periodDF, include,
                                     modStart = 0, modEnd = 0, units = NULL){
    if( ! "timeDF" %in% class(timeDF) ){
        stop("timeDF argument requires timeDF object")
    }
    time_var = attr(timeDF, "time_var")
    time_vec = timeDF[[time_var]]
    time_vec_num = as.numeric(time_vec)

    if( ! "periodDF" %in% class(periodDF) || attr(periodDF, "period_type") != "time"){
        stop("periodDF argument requires periodDF object with period_type of time")
    }else{
        start_time_vec = periodDF[[attr(periodDF, "start_var")]]
        end_time_vec = periodDF[[attr(periodDF, "end_var")]]
        if(is.null(attr(periodDF, "label_var"))){
            label_vec = NULL
        }else{
            label_vec = periodDF[[attr(periodDF, "label_var")]]
        }
    }

    start_vec_num = as.numeric(start_time_vec)
    end_vec_num = as.numeric(end_time_vec)

    if( include == "both" ){
    }else if(include == "right"){
        start_vec_num = start_vec_num + 1
    }else if(include == "left"){
        end_vec_num = end_vec_num - 1
    }else if(include == "none"){
        start_vec_num = start_vec_num + 1
        end_vec_num = end_vec_num - 1
    }else{
        stop("include argument requires 'both', 'right', 'left' or 'none' ")
    }

    if(modStart != 0 || modEnd != 0){
        if(is.null(units)){
            stop("units needs to be specified to modify starts or ends")
        }
        start_vec_num = start_vec_num + convert_to_seconds(modStart, unitsFrom = units)
        end_vec_num = end_vec_num + convert_to_seconds(modEnd, unitsFrom = units)
    }

    if(is.null(label_vec)){
        result_vec = as.logical( .cpp_times_within_periods(time_vec_num,
                                                           start_vec_num,
                                                           end_vec_num ) )
        result = result_vec
    }else{
        n_label = length(label_vec)
        result_list = list()
        for(i in seq(1, n_label)){
            label = label_vec[i]
            times_within = as.logical(
                .cpp_times_within_periods(time_vec_num,
                                          start_vec_num[i],
                                          end_vec_num[i])
            )
            if(is.null(result_list[[label]])){
                result_list[[label]] = times_within
            }else{
                result_list[[label]] = result_list[[label]] | times_within
            }
        }
        result = result_list
    }
    return(result)
}
