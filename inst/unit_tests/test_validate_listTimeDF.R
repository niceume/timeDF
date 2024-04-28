test_validate_listTimeDF = function(){
    time_df = timeDF::as.timeDF(
        data.frame(
            time = c("2024-01-01 01:00:00",
                     "2024-02-02 02:00:00",
                     "2024-03-03 03:00:00",
                     "2024-04-04 04:00:00",
                     "2024-05-05 05:00:00"),
            value = c(123,
                      144,
                      150,
                      100,
                      180)
        ))
    period_df = timeDF::as.periodDF(
        data.frame(
            start = c(
                "2024-01-01",
                "2024-02-01",
                "2024-03-01",
                "2024-04-01",
                "2024-05-01"
            ),
            end = c(
                "2024-01-31",
                "2024-02-29",
                "2024-03-31",
                "2024-04-30",
                "2024-05-31"
            ),
            label = c(
                "Jan",
                "Feb",
                "Mar",
                "Apr",
                "May"
            )
        ),
        period_type = "date",
        label_var = "label"
    )
    listTimeDF = timeDF::extract_with_periodDF(time_df,
                                       period_df,
                                       include="both")
    check = timeDF::validate_listTimeDF(listTimeDF, noerror=TRUE)

    RUnit::checkEquals(check, TRUE)
}
