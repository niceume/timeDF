validate_timeDF = function(timeDF, noerror = FALSE){
    if(! .is.timeDF(timeDF)){
        if(noerror){
            return(FALSE)
        }else{
            stop("not a valid timeDF object")
        }
    }
    return(TRUE)
}

## Internal
.is.timeDF = function(timeDF){
    if(! is(timeDF, "timeDF")){
        return(FALSE)
    }
    if( is.null(time_var(timeDF))){
        return(FALSE)
    }
    return(TRUE)
}
