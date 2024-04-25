test_period_type = function(){
    period_time = data.frame(
        start = c("2023-12-01 01:00:00",
                  "2023-12-01 02:00:00",
                  "2023-12-01 03:00:00",
                  "2023-12-02 04:00:00"),
        end = c("2023-12-01 02:00:00",
                "2023-12-01 03:00:00",
                "2023-12-01 04:00:00",
                "2023-12-02 05:00:00")
    )
    periodTime = timeDF::as.periodDF(period_time, "time")

    period_date = data.frame(
        start = c("2023-01-01",
                  "2023-01-14",
                  "2023-02-14",
                  "2023-03-14"),
        end = c("2023-01-31",
                "2023-02-14",
                "2023-03-14",
                "2023-04-14"),
        label = c("One", "Two", "Three", "Four")
    )
    periodDate = timeDF::as.periodDF(period_date, "date",
                             label_var = "label")

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
    periodTimeInDay = timeDF::as.periodDF(
        period_time_in_a_day,
        "time_in_a_day", label_var = "label")

    RUnit::checkEquals(timeDF::period_type(periodTime),
                       "time" )
    RUnit::checkEquals(timeDF::period_type(periodDate),
                       "date" )
    RUnit::checkEquals(timeDF::period_type(periodTimeInDay),
                       "time_in_a_day" )
}
