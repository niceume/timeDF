test_sort_periodDF = function(){
    period_time = data.frame(
        start = c("2023-12-02 04:00:00",
                  "2023-12-01 01:00:00",
                  "2023-12-01 03:00:00",
                  "2023-12-01 02:00:00"),
        end = c("2023-12-02 05:00:00",
                "2023-12-01 02:00:00",
                "2023-12-01 04:00:00",
                "2023-12-01 03:00:00"),
        labels = c("4:00", "1:00", "3:00", "2:00")
    )
    periodTime = timeDF::as.periodDF(period_time, "time", label_var = "labels")

    period_date = data.frame(
        start = c("2023-05-01",
                  "2023-01-01",
                  "2023-03-01",
                  "2023-02-01",
                  "2023-04-01"),
        end = c("2023-05-14",
                "2023-01-14",
                "2023-03-14",
                "2023-02-14",
                "2023-04-14"),
        labels = c("May", "Jan", "Mar", "Feb", "Apr")
    )
    periodDate = timeDF::as.periodDF(period_date, "date", label_var = "labels")

    period_time_in_a_day = data.frame(
        start = c("17:00",
                  "11:00",
                  "04:00"),
        end = c("24:00",
                "17:00",
                "11:00"),
        labels = c("evening",
                  "afternoon",
                  "morning")
    )
    periodTimeInDay = timeDF::as.periodDF(period_time_in_a_day,
                                  "time_in_a_day",
                                  label_var = "labels")

    sortedTime = timeDF::sort_periodDF(periodTime)
    sortedDate = timeDF::sort_periodDF(periodDate)
    sortedTimeInDay = timeDF::sort_periodDF(periodTimeInDay)

    RUnit::checkEquals( is(sortedTime, "periodDF"), TRUE )
    RUnit::checkEquals( is(sortedDate, "periodDF"), TRUE )
    RUnit::checkEquals( is(sortedTimeInDay, "periodDF"), TRUE )

    RUnit::checkEqualsNumeric( nrow(sortedTime) , 4)
    RUnit::checkEqualsNumeric( nrow(sortedDate) , 5)
    RUnit::checkEqualsNumeric( nrow(sortedTimeInDay) , 3)

    RUnit::checkEquals( sortedTime[["labels"]][1], "1:00")
    RUnit::checkEquals( sortedDate[["labels"]][1], "Jan")
    RUnit::checkEquals( sortedTimeInDay[["labels"]][1], "morning")
}
