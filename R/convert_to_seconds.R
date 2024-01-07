convert_to_seconds = function( value, unitsFrom ){
    units = unitsFrom

    if(units == "weeks"){
        result = value * 7 * 24 * 60 * 60
    }else if(units == "days"){
        result = value * 24 * 60 * 60
    }else if(units == "hours"){
        result = value * 60 * 60
    }else if(units == "mins"){
        result = value * 60
    }else if(units == "secs"){
        result = value
    }else{
        stop('"weeks", "days", "hours", "mins" or "secs" can be specified for unitsFrom argument')
    }

}
