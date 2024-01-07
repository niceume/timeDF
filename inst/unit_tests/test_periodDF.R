test_periodDF = function(){
    time_df = data.frame(
        time = c(
            "2023-01-01 12:00:00",
            "2023-02-10 12:00:00",
            "2023-03-02 12:00:00",
            "2023-03-14 12:00:00",
            "2023-04-11 12:00:00"
        ),
        value = c(123, 144, 150, 100, 130)
    )
    timeDF = timeDF::as.timeDF(time_df)

    period_time = data.frame(
        start = c("2023-01-01 12:00:00",
                  "2023-02-01 12:00:00",
                  "2023-03-01 12:00:00",
                  "2023-04-01 12:00:00"),
        end = c("2023-01-14 12:00:00",
                "2023-02-14 12:00:00",
                "2023-03-14 12:00:00",
                "2023-04-14 12:00:00"),
        labels = c("Phase1", "Phase2", "Phase3", "Phase4")
    )
    periodTime = timeDF::as.periodDF(period_time, "time", label_var = "labels")
    extracted_with_periodTime = timeDF::extract_with_periodDF(timeDF, periodTime, include="left")
    extracted_with_periodTimeR = timeDF::extract_with_periodDF(timeDF, periodTime, include="right")
    extracted_with_periodTimeB = timeDF::extract_with_periodDF(timeDF, periodTime, include="both")
    extracted_with_periodTimeN = timeDF::extract_with_periodDF(timeDF, periodTime, include="none")

    period_date = data.frame(
        start = c("2023-01-01",
                  "2023-02-01",
                  "2023-03-01",
                  "2023-04-01",
                  "2023-05-01"),
        end = c("2023-01-14",
                "2023-02-14",
                "2023-03-14",
                "2023-04-14",
                "2023-05-14"),
        labels = c("Jan", "Feb", "Mar", "Apr", "May")
    )
    periodDate = timeDF::as.periodDF(period_date, "date", label_var = "labels")
    extracted_with_periodDate = timeDF::extract_with_periodDF(timeDF, periodDate, include="both")
    extracted_with_periodDateL = timeDF::extract_with_periodDF(timeDF, periodDate, include="left")
    extracted_with_periodDateR = timeDF::extract_with_periodDF(timeDF, periodDate, include="right")
    extracted_with_periodDateN = timeDF::extract_with_periodDF(timeDF, periodDate, include="none")

    period_time_in_a_day = data.frame(
        start = c("04:00",
                  "12:00",
                  "17:00"),
        end = c("12:00",
                "17:00",
                "24:00"),
        label = c("morning",
                  "afternoon",
                  "evening")
    )
    periodTimeInDay = timeDF::as.periodDF(period_time_in_a_day,
                                  "time_in_a_day",
                                  label_var = "label")

    extracted_with_periodTimeInDay = timeDF::extract_with_periodDF(timeDF, periodTimeInDay, include="left")
    extracted_with_periodTimeInDayR = timeDF::extract_with_periodDF(timeDF, periodTimeInDay, include="right")
    extracted_with_periodTimeInDayB = timeDF::extract_with_periodDF(timeDF, periodTimeInDay, include="both")
    extracted_with_periodTimeInDayN = timeDF::extract_with_periodDF(timeDF, periodTimeInDay, include="none")
    
    RUnit::checkEquals( is(extracted_with_periodTime[[1]], "timeDF"), TRUE )
    RUnit::checkEquals( is(extracted_with_periodDate[[1]], "timeDF"), TRUE )
    RUnit::checkEquals( is(extracted_with_periodTimeInDay[[1]], "timeDF"), TRUE )
    
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTime[["Phase1"]]) , 1)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTime[["Phase2"]]) , 1)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTime[["Phase3"]]) , 1)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTime[["Phase4"]]) , 1)

    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeR[["Phase1"]]) , 0)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeR[["Phase2"]]) , 1)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeR[["Phase3"]]) , 2)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeR[["Phase4"]]) , 1)

    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeB[["Phase1"]]) , 1)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeB[["Phase2"]]) , 1)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeB[["Phase3"]]) , 2)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeB[["Phase4"]]) , 1)

    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeN[["Phase1"]]) , 0)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeN[["Phase2"]]) , 1)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeN[["Phase3"]]) , 1)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeN[["Phase4"]]) , 1)

    RUnit::checkEqualsNumeric( nrow(extracted_with_periodDate[["Jan"]]) , 1)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodDate[["Feb"]]) , 1)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodDate[["Mar"]]) , 2)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodDate[["Apr"]]) , 1)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodDate[["May"]]) , 0)

    RUnit::checkEqualsNumeric( nrow(extracted_with_periodDateL[["Jan"]]) , 1)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodDateL[["Feb"]]) , 1)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodDateL[["Mar"]]) , 1)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodDateL[["Apr"]]) , 1)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodDateL[["May"]]) , 0)

    RUnit::checkEqualsNumeric( nrow(extracted_with_periodDateR[["Jan"]]) , 0)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodDateR[["Feb"]]) , 1)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodDateR[["Mar"]]) , 2)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodDateR[["Apr"]]) , 1)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodDateR[["May"]]) , 0)

    RUnit::checkEqualsNumeric( nrow(extracted_with_periodDateN[["Jan"]]) , 0)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodDateN[["Feb"]]) , 1)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodDateN[["Mar"]]) , 1)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodDateN[["Apr"]]) , 1)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodDateN[["May"]]) , 0)

    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeInDay[["morning"]]) , 0)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeInDay[["afternoon"]]) , 5)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeInDay[["evening"]]) , 0)

    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeInDayR[["morning"]]) , 5)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeInDayR[["afternoon"]]) , 0)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeInDayR[["evening"]]) , 0)

    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeInDayB[["morning"]]) , 5)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeInDayB[["afternoon"]]) , 5)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeInDayB[["evening"]]) , 0)

    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeInDayN[["morning"]]) , 0)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeInDayN[["afternoon"]]) , 0)
    RUnit::checkEqualsNumeric( nrow(extracted_with_periodTimeInDayN[["evening"]]) , 0)
}
