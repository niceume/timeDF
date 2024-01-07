vec_to_periodDF = function( vec, period_type, duration, units,
                           format = "auto", labels = NULL, pre_margin = 0)
{
    if((length(duration)) != 1 && (length(duration) != length(vec))){
        stop("The length of duration argument needs to be 1 or the same length as vec")
    }
    if(! is.null(labels) &&
       (length(duration) != 1 ) &&
       (length(duration) != length(vec))){
        stop("The length of labels argument needs to be 1 or the same length as vec")
    }
    if(pre_margin < 0){
        stop("pre_margin argument needs to be specified as a positive number")
    }
    if((length(pre_margin)) != 1 && (length(pre_margin) != length(vec))){
        stop("The length of pre_margin argument needs to be 1 or the same length as vec")
    }

    if(period_type == "time"){
        if(format == "as_is"){
            confirm_time_object(vec)
            time_vec = vec
        }else{
            if(format == "auto"){
                format = "%Y-%m-%d %H:%M:%S"
            }
            time_vec = strptime(vec, format = format, tz = "UTC")
        }
        start_vec = time_vec - as.difftime(pre_margin, units = units)
        end_vec =  time_vec + as.difftime(duration, units = units)
    }else if(period_type == "date"){
        if(format == "as_is"){
            if(! is(vec, "Date")){
                stop("vec needs to be Date object")
            }
            date_vec = vec
        }else{
            if(format != "auto"){
                message("format is ignored in vec_to_periodDF function")
            }
            date_vec = as.Date(vec)
        }
        start_vec = date_vec - as.difftime(pre_margin, units = units)
        end_vec =  date_vec + as.difftime(duration, units = units)
    }else if(period_type == "time_in_a_day"){
        if(format == "as_is"){
            if(! is(vec, "numeric") || any(vec < 0 )|| any(vec > 24 * 60 * 60)){
                stop(paste("vec needs to be numeric ranging from 0 to ",
                           24 * 60 * 60, sep = ""))
            }
            time_offset = vec
        }else{
            if(format != "auto"){
                message("format is ignored in vec_to_periodDF function")
            }
            time_offset = convert_time_in_a_day_to_time_offset(vec)
        }
        if(units == "hours"){
            offset1 = pre_margin * 60 * 60
            offset2 = duration * 60 * 60
        }else if(units == "mins"){
            offset1 = pre_margin * 60
            offset2 = duration * 60
        }else if(units == "secs"){
            offset1 = pre_margin
            offset2 = duration
        }else{
            message("units is ignored in vec_to_periodDF function")
            offset1 = 0
            offset2 = 0
        }
        start_vec = time_offset - offset1
        end_vec = time_offset = offset2
    }

    if(is.null(labels)){
        periodDF = as.periodDF(
            data.frame(
                start = start_vec,
                end = end_vec
            ),
            period_type = period_type,
            format = "as_is"
        )
    }else{
        periodDF = as.periodDF(
            data.frame(
                start = start_vec,
                end = end_vec,
                label = labels
            ),
            period_type = period_type,
            format = "as_is",
            label_var = "label"
        )
    }
    return(periodDF)
}
