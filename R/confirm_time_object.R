confirm_time_object = function(obj){
    if(! is(obj, "POSIXlt") && ! is(obj, "POSIXct")){
        stop("column for time needs to be POSIXlt or POSIXct")
    }
}
