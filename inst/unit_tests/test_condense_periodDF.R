test_codense_periodDF = function(){
    period_time = data.frame(
        start = c("2023-12-01 01:00:00",
                  "2023-12-01 02:00:00",
                  "2023-12-01 03:00:00",
                  "2023-12-01 04:00:00"),
        end = c("2023-12-01 02:00:00",
                "2023-12-01 03:00:00",
                "2023-12-01 04:00:00",
                "2023-12-01 05:00:00"),
        labels = c("1:00", "2:00", "3:00", "4:00")
    )
    periodTime = timeDF::as.periodDF(period_time, "time", label_var = "labels")
    condensedTime1 = timeDF::condense_periodDF(periodTime, open=TRUE)
    condensedTime2 = timeDF::condense_periodDF(periodTime, open=FALSE)

    period_date = data.frame(
        start = c("2023-01-01",
                  "2023-02-01",
                  "2023-03-01",
                  "2023-04-01",
                  "2023-05-01"),
        end = c("2023-02-01",
                "2023-03-01",
                "2023-04-01",
                "2023-05-01",
                "2023-06-01"),
        labels = c("Jan", "Feb", "Mar", "Apr", "May")
    )
    periodDate = timeDF::as.periodDF(period_date, "date", label_var = "labels")
    condensedDate1 = timeDF::condense_periodDF(periodDate, open=TRUE)
    condensedDate2 = timeDF::condense_periodDF(periodDate, open=FALSE)
    
    period_time_in_a_day = data.frame(
        start = c("04:00",
                  "11:00",
                  "17:00"),
        end = c("11:00",
                "17:00",
                "24:00"),
        labels = c("morning",
                  "afternoon",
                  "eveing")
    )
    periodTimeInDay = timeDF::as.periodDF(period_time_in_a_day,
                                  "time_in_a_day",
                                  label_var = "labels")
    condensedTimeInDay1 = timeDF::condense_periodDF(periodTimeInDay, open=TRUE)
    condensedTimeInDay2 = timeDF::condense_periodDF(periodTimeInDay, open=FALSE)


    RUnit::checkEquals( is(condensedTime1, "periodDF"), TRUE )
    RUnit::checkEquals( is(condensedDate1, "periodDF"), TRUE )
    RUnit::checkEquals( is(condensedTimeInDay1, "periodDF"), TRUE )

    RUnit::checkEqualsNumeric( nrow(condensedTime1) , 4)
    RUnit::checkEqualsNumeric( nrow(condensedTime2) , 1)
    RUnit::checkEqualsNumeric( nrow(condensedDate1) , 5)
    RUnit::checkEqualsNumeric( nrow(condensedDate2) , 1)
    RUnit::checkEqualsNumeric( nrow(condensedTimeInDay1) , 3)
    RUnit::checkEqualsNumeric( nrow(condensedTimeInDay2) , 1)

    RUnit::checkEquals( condensedTime2[["labels"]][1], "1:00" )
    RUnit::checkEquals( condensedDate2[["labels"]][1], "Jan" )
    RUnit::checkEquals( condensedTimeInDay2[["labels"]][1], "morning" )
    
}
