test_sort_timeDF = function(){
    time_df = data.frame(
        time = c("2023-12-01 04:00:00",
                 "2023-12-01 03:00:00",
                 "2023-12-01 02:00:00",
                 "2023-12-02 01:00:00"),
        value = c(123,
                  144,
                  150,
                  100)
    )
    timeDF = timeDF::as.timeDF(time_df)
    sorted = timeDF::sort_timeDF(timeDF)
    earliest_time = timeDF::time_vec(sorted)[1]
    earliest_value = sorted[["value"]][1]

    RUnit::checkEquals(
               format(earliest_time,
                      "%Y-%m-%d %H:%M:%S"),
               "2023-12-01 02:00:00" )
    RUnit::checkEqualsNumeric(
               earliest_value, 150)
}
