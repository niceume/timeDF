test_convert_periodDF = function(){
    period_date = data.frame(
        start = c("2023-01-01",
                  "2023-02-01",
                  "2023-03-01",
                  "2023-04-01"),
        end = c("2023-01-14",
                "2023-02-14",
                "2023-03-14",
                "2023-04-14"),
        label = c("One", "Two", "Three", "Four")
    )
    periodDate = timeDF::as.periodDF(period_date, "date")
    convertedDate2Time = timeDF::convert_periodDF(periodDate, "time")

    period_time = data.frame(
        start = c("2023-12-01 03:00:00",
                  "2023-12-01 23:00:00",
                  "2023-12-03 00:00:00",
                  "2023-12-04 21:00:00"),
        end = c("2023-12-01 04:00:00",
                "2023-12-02 01:00:00",
                "2023-12-03 23:00:00",
                "2023-12-04 24:00:00")
    )
    periodTime = timeDF::as.periodDF(period_time, "time")
    convertedTime2Date = timeDF::convert_periodDF(periodTime, "date")
    convertedTime2TimeInDay = timeDF::convert_periodDF(periodTime, "time_in_a_day")

    period_time_in_a_day = data.frame(
        start = c("04:00",
                  "11:00",
                  "17:00"),
        end = c("11:00",
                "17:00",
                "24:00"),
        label = c("morning",
                  "afternoon",
                  "evening")
    )
    periodTimeInDay = timeDF::as.periodDF(period_time_in_a_day, "time_in_a_day", label_var = "label")
    convertedTimeInDay2Time = timeDF::convert_periodDF( periodTimeInDay, "time", base_date = "2023-10-01")

    RUnit::checkEquals( is(convertedDate2Time, "periodDF"), TRUE )
    RUnit::checkEquals( is(convertedTime2Date, "periodDF"), TRUE )
    RUnit::checkEquals( is(convertedTimeInDay2Time, "periodDF"), TRUE )

    RUnit::checkEquals( convertedDate2Time[1, "start"], strptime("2023-01-01 00:00:00", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
    RUnit::checkEquals( convertedDate2Time[2, "start"], strptime("2023-02-01 00:00:00", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
    RUnit::checkEquals( convertedDate2Time[3, "end"], strptime("2023-03-14 24:00:00", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
    RUnit::checkEquals( convertedDate2Time[4, "end"], strptime("2023-04-15 00:00:00", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
    
    RUnit::checkEquals( convertedTime2Date[1, "start"], as.Date("2023-12-01"))
    RUnit::checkEquals( convertedTime2Date[2, "end"], as.Date("2023-12-02"))
    RUnit::checkEquals( convertedTime2Date[3, "start"], as.Date("2023-12-03"))
    RUnit::checkEquals( convertedTime2Date[4, "end"], as.Date("2023-12-05"))
    
    RUnit::checkEquals( convertedTime2TimeInDay[1, "start"], 3 * 60 * 60)
    RUnit::checkEquals( convertedTime2TimeInDay[2, "start"], 23 * 60 * 60)
    RUnit::checkEquals( convertedTime2TimeInDay[2, "end"], 24 * 60 * 60)
    RUnit::checkEquals( convertedTime2TimeInDay[3, "start"], 0 * 60 * 60)
    RUnit::checkEquals( convertedTime2TimeInDay[3, "end"], 1 * 60 * 60)
    RUnit::checkEquals( convertedTime2TimeInDay[4, "start"], 0 * 60 * 60)
    RUnit::checkEquals( convertedTime2TimeInDay[4, "end"], 23 * 60 * 60)
    RUnit::checkEquals( convertedTime2TimeInDay[5, "end"], 24 * 60 * 60)
    
    RUnit::checkEquals( convertedTimeInDay2Time[1, "start"] , strptime("2023-10-01 04:00:00", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
    RUnit::checkEquals( convertedTimeInDay2Time[2, "start"] , strptime("2023-10-01 11:00:00", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
    RUnit::checkEquals( convertedTimeInDay2Time[2, "end"] , strptime("2023-10-01 17:00:00", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
    RUnit::checkEquals( convertedTimeInDay2Time[3, "end"] , strptime("2023-10-01 24:00:00", format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
}
