validate_sorted_timeDF = function(timeDF, noerror = FALSE){
    if(! .is.sorted_timeDF(timeDF)){
        if(noerror){
            return(FALSE)
        }else{
            stop("not a valid sorted timeDF object")
        }
    }
    return(TRUE)
}

## Internal
.is.sorted_timeDF = function(timeDF, decreasing = FALSE){
    if(! is(timeDF, "timeDF")){
        stop("timeDF argument needs to be timeDF class object")
    }
    order_vec = time_vec(timeDF)
    if(is.unsorted(order_vec)){
        return(FALSE)
    }else if(length(order_vec) == 0){
        return(TRUE)
    }else{ # sorted
        if(is.null(decreasing)){
            return(TRUE)
        }else if(decreasing){
            if(head(order_vec,1) >= tail(order_vec,1)){
                return(TRUE)
            }else{
                return(FALSE)
            }
        }else if(! decreasing){
            if(head(order_vec,1) <= tail(order_vec,1)){
                return(TRUE)
            }else{
                return(FALSE)
            }
        }
    }
}
