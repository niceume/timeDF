test_split_timeDF_by_intervals = function(){
    time_df = data.frame(
        time = c("2023-01-01 08:00:00",
                 "2023-01-01 12:00:00",
                 "2023-01-01 16:00:00",
                 "2023-01-02 08:00:00",
                 "2023-01-02 10:00:00",
                 "2023-01-03 11:00:00",
                 "2023-01-03 16:00:00",
                 "2023-01-05 12:00:00"
                 ),
        value = c(123, 144, 150, 100,
                  130, 145, 180, 100)
    )
    timeDF = timeDF::as.timeDF(time_df)

    splitted = timeDF::split_timeDF_by_intervals(timeDF,
                                                 1,
                                                 "days")

    message(length(splitted))
    RUnit::checkEqualsNumeric(length(splitted), 5)
    RUnit::checkEqualsNumeric(nrow(splitted[[1]]), 3)
    RUnit::checkEqualsNumeric(nrow(splitted[[2]]), 2)
    RUnit::checkEqualsNumeric(nrow(splitted[[3]]), 2)
    RUnit::checkEqualsNumeric(nrow(splitted[[4]]), 0)
    RUnit::checkEqualsNumeric(nrow(splitted[[5]]), 1)
}
