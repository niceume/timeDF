validate_listTimeDF = function(listTimeDF, noerror = FALSE){
    if(! .is.listTimeDF(listTimeDF)){
        if(noerror){
            return(FALSE)
        }else{
            stop("not a valid list of timeDF objects")
        }
    }
    return(TRUE)
}

# Internal
.is.listTimeDF = function(listTimeDF){
    if(! is(listTimeDF, "list")){
        return(FALSE)
    }

    if(! all(sapply(listTimeDF, function(elem){
        return( is(elem, "timeDF")) }))
    ){
        return(FALSE)
    }else{
        return(TRUE)
    }
}

split_timeDF_by_intervals = function(timeDF,
                                     byN,
                                     byUnits,
                                     modStart = 0,
                                     modEnd = 0,
                                     modUnits = "auto"){
    if(! is(timeDF, "timeDF")){
        stop("timeDF argument needs to be timeDF class object")
    }

    if(! byUnits %in% c("days", "hours", "mins")){
        stop("byUnits needs to be days, hours or mins")
    }

    if(modUnits == "auto"){
        unit_conv = list(
            "days" = "hours",
            "hours" = "mins",
            "mins" = "secs"
        )
        if(is.null(unit_conv[[byUnits]])){
            stop("unknown unit conversion")
        }else{
            modUnits = unit_conv[[byUnits]]
        }
    }

    time_vec= time_vec(timeDF)
    min_time = min(time_vec)
    max_time = max(time_vec)
    if(byUnits == "days"){
        start_date = as.Date(format(min_time, "%Y-%m-%d"))
        end_date = as.Date(format(max_time, "%Y-%m-%d"))
        day_labels_df = data.frame(
            start = seq(start_date, end_date, 1),
            end = seq(start_date, end_date, 1) + 1,
            label = format(seq(start_date, end_date, 1), "%Y-%m-%d")
        )
        periodLabels = as.periodDF(day_labels_df, "date",
                                format = "as_is", label_var = "label")
    }else if(byUnits %in% c("hours", "mins")){
        if(byUnits == "hours"){
            time_format = "%Y-%m-%d %H:00:00"
        }else if(byUnits == "mins"){
            time_format = "%Y-%m-%d %H:%M:00"
        }
        start_time = strptime(format(min_time,
                                     time_format,
                                     tz = "UTC"))
        end_time = strptime(format(max_time,
                                   time_format,
                                   tz = "UTC")) +
            as.difftime(byN, units = byUnits)
        period_labels_df = data.frame(
            start = seq(start_time, end_time, as.difftime(byN, units = byUnits)),
            end = seq(start_time, end_time, as.difftime(byN, units = byUnits)),
            label = format(seq(start_date, end_date,
                               as.difftime(byN, units = byUnits)),
                           "%Y-%m-%d %H:00:00")
        )
        periodLabels = as.periodDF(period_labels_df, "time",
                                format = "as_is", label_var = "label")
    }else{
        stop("unknown byUnits specified")
    }

    extracted_timeDF_list = extract_with_periodDF(timeDF,
                                                  periodLabels,
                                                  include = "left",
                                                  modStart = modStart,
                                                  modEnd = modEnd,
                                                  units = modUnits)
    return(extracted_timeDF_list)
}

listTimeDF_to_timeDF = function(listTimeDF, name_var = "name"){
    validate_listTimeDF(listTimeDF)
    result = data.frame()
    for( i in seq(1, length(listTimeDF))){
        df = listTimeDF[[i]]
        name = names(listTimeDF)[[i]]
        if( nrow(df) != 0 ){
            # without this logic,
            # "replacement has 1 row, data has 0" error
            df[[name_var]] = name
        }
        result = rbind(result, df)
    }
    result = as.timeDF(result, format = "as_is")
    return(result)
}

