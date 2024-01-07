test_flag_with_periodDF = function(){
    set.seed(100)
    times = data.frame(
        time = seq(strptime("2023-12-01 00:00:00", format = "%Y-%m-%d %H:%M:%S", tz= "UTC"),
                   by = as.difftime(15, units = "mins"), length.out = 400),
        value = 50 + 150 * runif(400))
    # 2023-12-01 00:00:00 - 2023-12-05 03:45:00
    timeDF = timeDF::as.timeDF(times, format = "as_is")

    period_time = data.frame(
        start = c("2023-11-30 08:00:00",
                  "2023-12-01 08:00:00",
                  "2023-12-02 08:00:00"),
        end = c("2023-11-30 12:00:00",
                "2023-12-01 12:00:00",
                "2023-12-02 12:00:00"),
        label = c("11-30", "12-01", "12-02")
    )
    periodTime = timeDF::as.periodDF(period_time, "time", label_var = "label")
    flaggedWithTime = timeDF::flag_with_periodDF(timeDF, periodTime,
                                                 flag_var = "flag",
                                                 include = "left",
                                                 modStart = -1, modEnd = +1,
                                                 units = "hours")

    period_date = data.frame(
        start = c("2023-11-01",
                  "2023-11-02",
                  "2023-12-01",
                  "2023-12-02"),
        end = c("2023-11-01",
                "2023-11-02",
                "2023-12-01",
                "2023-12-02"),
        label = c("11-01", "11-02", "12-01", "12-02")
    )
    periodDate = timeDF::as.periodDF(period_date, "date", label_var = "label")
    flaggedWithDate = timeDF::flag_with_periodDF(timeDF, periodDate,
                                                 flag_var = "flag",
                                                 include = "both")

    period_time_in_day = data.frame(
        start = c("8:00",
                  "18:00"),
        end = c("12:00",
                "23:00"),
        label = c("morning", "evening")
    )
    periodTimeInDay = timeDF::as.periodDF(period_time_in_day, "time_in_a_day", label_var = "label")
    flaggedWithTimeInDay = timeDF::flag_with_periodDF(timeDF, periodTimeInDay,
                                                      flag_var = "flag",
                                                      include = "left",
                                                      modStart = +2, modEnd = +2,
                                                      units = "hours")

    RUnit::checkEquals( is(flaggedWithTime, "timeDF"), TRUE )
    RUnit::checkEquals( is(flaggedWithDate, "timeDF"), TRUE )
    RUnit::checkEquals( is(flaggedWithTimeInDay, "timeDF"), TRUE )

    subFlaggedWithTime1 = flaggedWithTime[! is.na(flaggedWithTime$flag) & flaggedWithTime$flag == "11-30",]
    subFlaggedWithTime2 = flaggedWithTime[! is.na(flaggedWithTime$flag) & flaggedWithTime$flag == "12-02",]
    RUnit::checkEquals( nrow(subFlaggedWithTime1), 0)
    RUnit::checkEquals( nrow(subFlaggedWithTime2), 24)
    RUnit::checkEquals( head(subFlaggedWithTime2, 1)$time, strptime("2023-12-02 07:00:00", format = "%Y-%m-%d %H:%M:%S", tz="UTC"))
    RUnit::checkEquals( tail(subFlaggedWithTime2, 1)$time, strptime("2023-12-02 12:45:00", format = "%Y-%m-%d %H:%M:%S", tz="UTC"))

    subFlaggedWithDate1 = flaggedWithDate[! is.na(flaggedWithDate$flag) & flaggedWithDate$flag == "11-01",]
    subFlaggedWithDate2 = flaggedWithDate[! is.na(flaggedWithDate$flag) & flaggedWithDate$flag == "12-02",]
    RUnit::checkEquals( nrow(subFlaggedWithDate1), 0)
    RUnit::checkEquals( nrow(subFlaggedWithDate2), 96)
    RUnit::checkEquals( head(subFlaggedWithDate2, 1)$time, strptime("2023-12-02 00:00:00", format = "%Y-%m-%d %H:%M:%S", tz="UTC"))
    RUnit::checkEquals( tail(subFlaggedWithDate2, 1)$time, strptime("2023-12-02 23:45:00", format = "%Y-%m-%d %H:%M:%S", tz="UTC"))

    subFlaggedWithTimeInDay1 = flaggedWithTimeInDay[! is.na(flaggedWithTimeInDay$flag) & flaggedWithTimeInDay$flag == "evening",]
    RUnit::checkEquals( nrow(subFlaggedWithTimeInDay1), 84)
    RUnit::checkEquals( head(subFlaggedWithTimeInDay1, 1)$time, strptime("2023-12-01 00:00:00", format = "%Y-%m-%d %H:%M:%S", tz="UTC"))
    RUnit::checkEquals( tail(subFlaggedWithTimeInDay1, 1)$time, strptime("2023-12-05 00:45:00", format = "%Y-%m-%d %H:%M:%S", tz="UTC"))
}
