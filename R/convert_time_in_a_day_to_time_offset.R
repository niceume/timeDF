convert_time_in_a_day_to_time_offset = function(time_str, validate=TRUE){
    hm_bool = grepl("^\\d*:\\d*$", time_str)
    hms_bool = grepl("^\\d*:\\d*:\\d*$", time_str)
    offset = rep(NA, length(time_str))

    if(sum(as.integer(hm_bool)) > 0){
        hm_time_str = time_str[hm_bool]
        hm_time_nums = strsplit(hm_time_str, ":")
        hm_offset = sapply(hm_time_nums, function(hm){
            hm_hour = as.integer(hm[1])
            hm_min = as.integer(hm[2])
            hm_sec = 0
            hm_offset = (60 * hm_hour + hm_min ) * 60 + hm_sec
            return(hm_offset)
        })
        offset[hm_bool] = hm_offset
    }

    if(sum(as.integer(hms_bool)) > 0){
        hms_time_str = time_str[hms_bool]
        hms_time_nums = strsplit(hms_time_str, ":")
        hms_offset = sapply(hms_time_nums, function(hms){
            hms_hour = as.integer(hms[1])
            hms_min = as.integer(hms[2])
            hms_sec = as.integer(hms[3])
            hms_offset = (60 * hms_hour + hms_min ) * 60 + hms_sec
            return(hms_offset)
        })
        offset[hms_bool] = hms_offset
    }

    if(validate == TRUE){
        if(any(offset < 0) || any(offset > 24 * 60 * 60)){
            stop("time in a day should be specified from 00:00 to 24:00")
        }
    }

    return(offset)
}

