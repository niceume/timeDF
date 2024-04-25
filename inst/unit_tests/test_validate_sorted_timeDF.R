test_validate_sorted_timeDF = function(){
    time_df = data.frame(
        time = c("2023-12-04 02:00:00",
                 "2023-12-01 03:00:00",
                 "2023-12-02 01:00:00",
                 "2023-12-03 04:00:00"),
        value = c(123,
                  144,
                  150,
                  100)
    )
    timeDF = timeDF::as.timeDF(time_df)

    RUnit::checkEquals(
               timeDF::validate_sorted_timeDF(
                   timeDF,
                   noerror=TRUE),
               FALSE)

    sorted_timeDF = timeDF::sort_timeDF(timeDF)
    RUnit::checkEquals(
               timeDF::validate_sorted_timeDF(
                   sorted_timeDF,
                   noerror=TRUE),
               TRUE)
}
