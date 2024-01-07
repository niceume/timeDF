sort_periodDF = function(periodDF, by="start"){
    order_var = NULL
    if(by == "start"){
        order_var = attr(periodDF, "start_var")
    }else if (by == "end"){
        order_var = attr(periodDF, "end_var")
    }else{
        stop("by argument needs 'start' or 'end'")
    }

    result = periodDF[order(periodDF[[order_var]], decreasing = FALSE),]
    return(result)
}
