condense_periodDF = function(periodDF, open = TRUE, useData = "start"){
    if( ! "periodDF" %in% class(periodDF) ){
        stop("periodDF argument requires periodDF object")
    }

    # if not sorted in increasing order
    if( is.unsorted(periodDF[[attr(periodDF, "start_var")]])){
        periodDF = sort_periodDF(periodDF, by = "start")
    }

    start_vec = periodDF[[attr(periodDF, "start_var")]]
    end_vec = periodDF[[attr(periodDF, "end_var")]]

    stored_start_indices = c()
    stored_end_indices = c()
    temp_start_index = NULL
    temp_end_value = NULL
    temp_end_index = NULL
    new_period = TRUE
    for( i in seq(1, length(start_vec))){
        current_start_value = start_vec[i]
        current_end_value = end_vec[i]
        if(new_period == TRUE){
            temp_start_index = i
            temp_end_value = current_end_value
            temp_end_index = i
            new_period = FALSE
        }else if( temp_end_value <= current_end_value){
            temp_end_value = current_end_value
            temp_end_index = i
        }else{
            # nop
        }

        if(i == length(start_vec)){ # Last record
            stored_start_indices = c(stored_start_indices, temp_start_index)
            stored_end_indices = c(stored_end_indices, temp_end_index)
        }else{# Compare with temp end value with next record
            next_start_value = start_vec[i + 1]
            if(is_smaller(temp_end_value , next_start_value, open)){
                stored_start_indices = c(stored_start_indices, temp_start_index)
                stored_end_indices = c(stored_end_indices, temp_end_index)
                temp_start_index = NULL
                temp_end_value = NULL
                temp_end_index = NULL
                new_period = TRUE
            }
        }
    }

    if(length(stored_start_indices) != length(stored_end_indices)){
        stop("mismatch in stored start and end indices")
    }

    result_df = data.frame()
    for( i in seq(1, length(stored_start_indices))){
        if(stored_start_indices[i] == stored_end_indices[i]){
            result_df = rbind(result_df, periodDF[stored_start_indices[i],])
        }else{
            start_record = periodDF[stored_start_indices[i],]
            end_record = periodDF[stored_end_indices[i],]
            if(useData == "start"){
                start_record[[attr(periodDF,"end_var")]] =
                    end_record[[attr(periodDF,"end_var")]]
                result_df = rbind(result_df, start_record)
            }else if(useData == "end"){
                end_record[[attr(periodDF,"start_var")]] =
                    start_record[[attr(periodDF,"start_var")]]
                result_df = rbind(result_df, end_record)
            }else{
                stop("unknown useData argument")
            }
        }
    }

    attr(result_df, "class") = c( attr(result_df, "class"), "periodDF")
    attr(result_df, "period_type") = attr(periodDF, "period_type")
    attr(result_df, "start_var") = attr(periodDF, "start_var")
    attr(result_df, "end_var") = attr(periodDF, "end_var")
    attr(result_df, "label_var") = attr(periodDF, "label_var")
    return(result_df)
}

is_smaller = function( x, y, open){
    if( open ){
        x <= y
    }else{
        x < y
    }
}
