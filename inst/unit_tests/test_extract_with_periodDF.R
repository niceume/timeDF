test_extract_with_periodDF = function(){
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
    extractedWithTime = timeDF::extract_with_periodDF(timeDF, periodTime, include = "left",
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
    extractedWithDate = timeDF::extract_with_periodDF(timeDF, periodDate, include = "both",
                                                      modStart = -4, modEnd = +4,
                                                      units = "hours")

    period_time_in_day = data.frame(
        start = c("8:00",
                  "18:00"),
        end = c("12:00",
                "23:00"),
        label = c("morning", "evening")
    )
    periodTimeInDay = timeDF::as.periodDF(period_time_in_day, "time_in_a_day", label_var = "label")
    extractedWithTimeInDay = timeDF::extract_with_periodDF(timeDF, periodTimeInDay, include = "left",
                                                           modStart = +2, modEnd = +2,
                                                           units = "hours")

    RUnit::checkEquals( is(extractedWithTime, "list"), TRUE )
    RUnit::checkEquals( is(extractedWithTime[["11-30"]], "timeDF"), TRUE )
    RUnit::checkEquals( is(extractedWithTime[["12-02"]], "timeDF"), TRUE )
    RUnit::checkEquals( is(extractedWithDate, "list"), TRUE )
    RUnit::checkEquals( is(extractedWithDate[["11-01"]], "timeDF"), TRUE )
    RUnit::checkEquals( is(extractedWithDate[["12-02"]], "timeDF"), TRUE )
    RUnit::checkEquals( is(extractedWithTimeInDay, "list"), TRUE )
    RUnit::checkEquals( is(extractedWithTimeInDay[["morning"]], "timeDF"), TRUE )

    RUnit::checkEquals( nrow(extractedWithTime[["11-30"]]), 0)
    RUnit::checkEquals( nrow(extractedWithTime[["12-02"]]), 24)
    RUnit::checkEquals( head(extractedWithTime[["12-02"]], 1)$time, strptime("2023-12-02 07:00:00", format = "%Y-%m-%d %H:%M:%S", tz="UTC"))
    RUnit::checkEquals( tail(extractedWithTime[["12-02"]], 1)$time, strptime("2023-12-02 12:45:00", format = "%Y-%m-%d %H:%M:%S", tz="UTC"))

    RUnit::checkEquals( nrow(extractedWithDate[["11-01"]]), 0)
    RUnit::checkEquals( nrow(extractedWithDate[["12-02"]]), 128)
    RUnit::checkEquals( head(extractedWithDate[["12-02"]], 1)$time, strptime("2023-12-01 20:00:00", format = "%Y-%m-%d %H:%M:%S", tz="UTC"))
    RUnit::checkEquals( tail(extractedWithDate[["12-02"]], 1)$time, strptime("2023-12-03 03:45:00", format = "%Y-%m-%d %H:%M:%S", tz="UTC"))

    RUnit::checkEquals( nrow(extractedWithTimeInDay[["evening"]]), 84)
    RUnit::checkEquals( head(extractedWithTimeInDay[["evening"]], 1)$time, strptime("2023-12-01 00:00:00", format = "%Y-%m-%d %H:%M:%S", tz="UTC"))
    RUnit::checkEquals( tail(extractedWithTimeInDay[["evening"]], 1)$time, strptime("2023-12-05 00:45:00", format = "%Y-%m-%d %H:%M:%S", tz="UTC"))
}
