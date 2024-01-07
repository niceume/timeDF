flag_with_periodDF = function(timeDF, periodDF, flag_var, include,
                              modStart = 0, modEnd = 0, units = NULL){
    if( ! "timeDF" %in% class(timeDF) ){
        stop("timeDF argument requires timeDF object")
    }
    if( ! "periodDF" %in% class(periodDF) ){
        stop("periodDF argument requires periodDF object")
    }
    if( ! is(flag_var, "character") ){
        stop("flag_var argument requires character object")
    }

    if( is.null(attr(periodDF, "label_var")) ){
        result_bool = extract_with_periodDF(timeDF, periodDF, include, outputAsBool = TRUE, modStart, modEnd, units)
        timeDF[[flag_var]] = result_bool
    }else{
        result_bool_list = extract_with_periodDF(timeDF, periodDF, include, outputAsBool = TRUE, modStart, modEnd, units)
        labels = names(result_bool_list)
        flag_accum = rep(NA, nrow(timeDF))
        caution = FALSE
        for( label in labels ){
            if(any( ( !is.na(flag_accum) ) & result_bool_list[[label]] )){
                # label is assined to non-NA positions.
                caution = TRUE
            }
            flag_accum[result_bool_list[[label]]] = label
        }
        if(caution){
            message("Some periods may be overlapped")
            message("Which label to be assigned can vary on environments and locales when a time record exists within such periods")
        }
        timeDF[[flag_var]] = flag_accum
    }
    return(timeDF)
}
