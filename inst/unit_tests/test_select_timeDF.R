test_select_timeDF = function(){
    time_df = data.frame(
        time = c("2023-12-01 01:00:00",
                 "2023-12-01 05:00:00",
                 "2023-12-01 09:00:00",
                 "2023-12-01 13:00:00",
                 "2023-12-01 17:00:00",
                 "2023-12-01 21:00:00"),
        value = c(123,
                  144,
                  150,
                  100,
                  200,
                  180),
        phase = c("A",
                  "A",
                  "B",
                  "B",
                  "C",
                  "C")
    )
    timeDF = timeDF::as.timeDF(time_df)
    names = colnames(
        timeDF::select_timeDF(
            timeDF, c("phase")))
    RUnit::checkEquals(
               all( names %in% c("time", "phase")), TRUE )
}
