examine_with_time_periods_within_a_day = function( timeDF, periodDF, include,
                                                  modStart = 0, modEnd = 0, units = NULL ){
    if( ! "timeDF" %in% class(timeDF) ){
        stop("timeDF argument requires timeDF object")
    }

    time_var = attr(timeDF, "time_var")
    time_vec= timeDF[[time_var]]
    time_hour_vec = as.integer(format(time_vec, "%H"))
    time_min_vec = as.integer(format(time_vec, "%M"))
    time_sec_vec = as.integer(format(time_vec, "%S"))
    time_offset_vec = (time_hour_vec * 60 + time_min_vec) * 60 + time_sec_vec

    if(modStart != 0 || modEnd != 0){
        if(is.null(units)){
            stop("units needs to be specified to modify starts or ends")
        }else{
            periodDF = adjust_periodDF(periodDF, modStart, modEnd, units)
        }
    }

    if( ! "periodDF" %in% class(periodDF) || attr(periodDF, "period_type") != "time_in_a_day"){
        stop("periodDF argument requires periodDF object with period_type of time_in_a_day")
    }else{
        start_offset_vec = periodDF[[attr(periodDF, "start_var")]]
        end_offset_vec = periodDF[[attr(periodDF, "end_var")]]
        if(is.null(attr(periodDF, "label_var"))){
            label_vec = NULL
        }else{
            label_vec = periodDF[[attr(periodDF, "label_var")]]
        }
    }

    if( include == "both" ){
    }else if(include == "right"){
        start_offset_vec = start_offset_vec + 1
    }else if(include == "left"){
        end_offset_vec = end_offset_vec - 1
    }else if(include == "none"){
        start_offset_vec = start_offset_vec + 1
        end_offset_vec = end_offset_vec - 1
    }else{
        stop("include argument requires 'both', 'right', 'left' or 'none' ")
    }

    n_period = length(start_offset_vec)
    if(is.null(label_vec)){
        labels = as.character(seq(1, n_period))
    }else{
        labels = label_vec
    }

    result_list = list()
    for( i in seq(1, n_period) ){
        label = labels[i]
        times_within = (! is.na(time_offset_vec)) &
            (start_offset_vec[i] <= time_offset_vec ) & (time_offset_vec <= end_offset_vec[i])

        if(is.null(result_list[[label]])){
            result_list[[label]] = times_within
        }else{
            result_list[[label]] = result_list[[label]] | times_within
        }
    }

    if(is.null(label_vec)){
        result_vec = Reduce(function(a,b){return(a | b)}, result_list)
        return( result_vec )
    }else{
        return( result_list )
    }
}
