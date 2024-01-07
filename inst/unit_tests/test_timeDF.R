test_timeDF = function(){
    time_df = data.frame(
        time = c(
            "2023-01-01 12:00:00",
            "2023-02-10 12:00:00",
            "2023-03-02 12:00:00",
            "2023-03-22 12:00:00",
            "2023-04-11 12:00:00"
        ),
        value = c(123, 144, 150, 100, 130)
    )
    timeDF = timeDF::as.timeDF(time_df)

    period_df = data.frame(
        start = c("2023-03-01",
                  "2023-01-01"),
        end = c("2023-03-31",
                "2023-01-31")
    )
    periodDF = timeDF::as.periodDF(period_df, "date")
    sorted_periodDF = timeDF::sort_periodDF(periodDF)

    extracted_timeDF = timeDF::extract_with_periodDF(timeDF, sorted_periodDF, "both")

    RUnit::checkEquals( is(timeDF, "timeDF"), TRUE )
    RUnit::checkEquals( is(periodDF, "periodDF"), TRUE )
    RUnit::checkEquals( is(sorted_periodDF, "periodDF"), TRUE )
    RUnit::checkEquals( is(extracted_timeDF, "timeDF"), TRUE )
    
    RUnit::checkEqualsNumeric( nrow(extracted_timeDF) , 3)
}
