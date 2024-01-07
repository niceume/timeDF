test_adjust_periodDF = function(){
    period_time = data.frame(
        start = c("2023-12-01 03:00:00",
                  "2023-12-01 20:00:00",
                  "2023-12-02 05:00:00",
                  "2023-12-03 21:00:00"),
        end = c("2023-12-01 04:00:00",
                "2023-12-01 21:00:00",
                "2023-12-02 06:00:00",
                "2023-12-03 22:00:00")
    )
    periodTime = timeDF::as.periodDF(period_time, "time")
    adjTime = timeDF::adjust_periodDF(periodTime, -1, 3, units="hours")

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
    adjDate = timeDF::adjust_periodDF(periodDate, -1, 1, units="days")

    period_time_in_a_day = data.frame(
        start = c("01:00",
                  "12:00",
                  "18:00"),
        end = c("12:00",
                "18:00",
                "24:00"),
        label = c("morning",
                  "afternoon",
                  "evening")
    )
    periodTimeInDay = timeDF::as.periodDF(period_time_in_a_day, "time_in_a_day", label_var = "label")
    adjTimeInDay1 = timeDF::adjust_periodDF( periodTimeInDay, 1, 1, "hours")
    adjTimeInDay2 = timeDF::adjust_periodDF( periodTimeInDay, -2, -1, "hours")

    RUnit::checkEquals( is(adjTime, "periodDF"), TRUE )
    RUnit::checkEquals( is(adjDate, "periodDF"), TRUE )
    RUnit::checkEquals( is(adjTimeInDay1, "periodDF"), TRUE )
    RUnit::checkEquals( is(adjTimeInDay2, "periodDF"), TRUE )

    RUnit::checkEqualsNumeric( nrow(adjTime), 4)
    RUnit::checkEqualsNumeric( nrow(adjDate), 4)
    RUnit::checkEqualsNumeric( nrow(adjTimeInDay1), 4)
    RUnit::checkEqualsNumeric( nrow(adjTimeInDay2), 4)
}
