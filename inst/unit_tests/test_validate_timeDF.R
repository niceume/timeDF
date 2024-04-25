test_validate_timeDF = function(){
    time_df = data.frame(
        time = c("2023-12-01 01:00:00",
                 "2023-12-01 02:00:00",
                 "2023-12-01 03:00:00",
                 "2023-12-02 04:00:00"),
        value = c(123,
                  144,
                  150,
                  100)
    )
    timeDF = timeDF::as.timeDF(time_df)

    RUnit::checkEquals(
               timeDF::validate_timeDF(
                   timeDF,
                   noerror=TRUE),
               TRUE)
    RUnit::checkEquals(
               timeDF::validate_timeDF(
                   data.frame(),
                   noerror=TRUE),
               FALSE)
}
