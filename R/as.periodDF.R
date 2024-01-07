as.periodDF = function(df, period_type,
                       format = "auto",
                       start_var = "start", end_var = "end",
                       label_var = NULL){

    available_types = c("time", "date", "time_in_a_day")
    if(! period_type %in% available_types){
        stop(paste("period_type should be specified from (",
                   paste(available_types, collapse=", "), ")",  sep = " "))
    }
    if(is.null(df[[start_var]]) || is.null(df[[end_var]])){
        stop(paste("df requires columns (",
                   start_var, ",", end_var, ")", sep = " " ))
    }
    if((! is.null(label_var)) && is.null(df[[label_var]])){
        stop(paste("df requires column (",
                   label_var, ")", sep = " "))
    }

    if(format == "as_is"){
        if(period_type == "time"){
            start_time_vec = df[[start_var]]
            end_time_vec = df[[end_var]]
            confirm_time_object(start_time_vec)
            confirm_time_object(end_time_vec)
            if(! "UTC" %in% attr(start_time_vec, "tzone") ||
                     ! "UTC" %in% attr(end_time_vec, "tzone")) {
                stop("columns for start and end need to have UTC timezones")
            }
            df[[start_var]] = start_time_vec
            df[[end_var]] = end_time_vec
        }else if(period_type == "date"){
            start_date_vec = df[[start_var]]
            end_date_vec = df[[end_var]]
            if(! is(start_date_vec, "Date") || ! is(end_date_vec, "Date")){
                stop("columns for start and end need to be Date")
            }
            df[[start_var]] = start_date_vec
            df[[end_var]] = end_date_vec
        }else if(period_type == "time_in_a_day"){
            start_offset_vec = df[[start_var]]
            end_offset_vec = df[[end_var]]
            max_sec_in_a_day = 24 * 60 * 60
            if(! is(start_offset_vec, "numeric") || ! is(end_offset_vec, "numeric")){
                stop("columns for start and end need to be numeric")
            }
            if(any(start_offset_vec < 0) || any(end_offset_vec < 0) ||
               any(start_offset_vec > max_sec_in_a_day) || any(end_offset_vec > max_sec_in_a_day)){
                stop(paste("columns for start and end need to be from zero to ", max_sec_in_a_day ,sep=""))
            }
            df[[start_var]] = start_offset_vec
            df[[end_var]] = end_offset_vec
        }
    }else{
        if((! typeof(df[[start_var]]) == "character" ) ||
           (! typeof(df[[end_var]]) == "character" )) {
            stop(paste("df requires character columns for (",
                       start_var, end_var, ")", sep = "," ))
        }
        if(period_type == "time_in_a_day"){
            if( ! all( grepl("^\\d*:\\d*$", df[[start_var]]) |
                       grepl("^\\d*:\\d*:\\d$", df[[start_var]]) )){
                stop(paste("df requires time in a day format for column", start_var , sep =" "))
            }
            if( ! all( grepl("^\\d*:\\d*$", df[[end_var]]) |
                       grepl("^\\d*:\\d*:\\d$", df[[end_var]]) )){
                stop(paste("df requires time in a day format for column", end_var , sep =" "))
            }
        }
        
        if(format == "auto"){
            if(period_type == "time" ){
                format = "%Y-%m-%d %H:%M:%S"
            }else if(period_type == "date"){
                format = NULL
            }else if(period_type == "time_in_a_day"){
                format = NULL
            }
        }
        if(period_type == "time"){
            start_time_vec = strptime( df[[start_var]], format, tz = "UTC")
            end_time_vec = strptime( df[[end_var]], format, tz = "UTC")
            df[[start_var]] = start_time_vec
            df[[end_var]] = end_time_vec
        }else if(period_type == "date"){
            start_date_vec = as.Date( df[[start_var]] )
            end_date_vec = as.Date( df[[end_var]] )
            df[[start_var]] = start_date_vec
            df[[end_var]] = end_date_vec
        }else if(period_type == "time_in_a_day"){
            start_offset_vec = convert_time_in_a_day_to_time_offset( df[[start_var]] )
            end_offset_vec = convert_time_in_a_day_to_time_offset( df[[end_var]] )
            df[[start_var]] = start_offset_vec
            df[[end_var]] = end_offset_vec
        }
    }

    attr(df, "class") = c("periodDF", attr(df, "class"))
    attr(df, "period_type") = period_type
    attr(df, "start_var") = start_var
    attr(df, "end_var") = end_var
    attr(df, "label_var") = label_var
    return( df )
}
