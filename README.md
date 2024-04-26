# R package timeDF

## About timeDF package

Package timeDF provides functionality to deal with times with the use of periods. With period information, data frames with time information are subset and flagged. Data frames with times are dealt as timeDF objects and periods are represented as periodDF objects.


## Example

### Data frame to timeDF

* Prepare a data frame for timeDF

The following code generates a data frame with time of 2023-12-01 00:00:00 to 2023-12-05 23:45:00 with each interval of 15 minutes. Each value is random value from 50 to 200 which are just dummy values for this example.

```
library(timeDF)

set.seed(100)
times = data.frame(
    time = seq(strptime("2023-12-01 00:00:00", format = "%Y-%m-%d %H:%M:%S", tz= "UTC"),
                   by = as.difftime(15, units = "mins"), length.out = 480),
    value = 50 + 150 * runif(480)
    )
```

* Convert the data frame into timeDF

Column name for time can be explicitly specified, but in this case, column name for time is "time", which is default value. Also, the column for time is already compatible with R time format, POSIXlt or POSIXct. You do not need to convert it, so it is specified as "as_is" for the format argument. 

```
timeDF = as.timeDF(times, format = "as_is")
```

* Prepare a data frame for periodDF

```
periods = data.frame(
    start = c("2023-12-02 10:00:00", "2023-12-04 10:00:00"),
    end = c("2023-12-02 12:00:00", "2023-12-04 12:00:00")
)
```

* Convert the data frame into periodDF

With periodDF, periods can be specified by periods between pairs of times, dates or times within a day. In this case, period_type is specified as "time". Column names for start and end can be explicitly specified, but in this case, column names for starts and ends are "start" and "end", which are default values.

```
periodDF = as.periodDF(periods, period_type = "time")
```

* Extract timeDF records within periods of periodDF

From timeDF, records within periods can be extracted. It is important to consider whether each side is included or not. In the following example, only the left side is included.

```
extracted = extract_with_periodDF(timeDF, periodDF, include = "left")
```

* Output

```
2023-12-02 10:00:00 120.81948
2023-12-02 10:15:00  56.35846
2023-12-02 10:30:00 119.47316
2023-12-02 10:45:00 144.49922
2023-12-02 11:00:00 150.98739
2023-12-02 11:15:00  63.05520
2023-12-02 11:30:00  71.53757
2023-12-02 11:45:00 186.27177
2023-12-04 10:00:00 125.40319
2023-12-04 10:15:00 186.74562
2023-12-04 10:30:00  89.66238
2023-12-04 10:45:00  76.07853
2023-12-04 11:00:00 110.04969
2023-12-04 11:15:00 130.75361
2023-12-04 11:30:00  86.74466
2023-12-04 11:45:00 106.37764
```


## timeDF

#### When you convert data frames with time in character into timeDF

You can specify format for time as you want. The default is "%Y-%m-%d %H:%M:%S", but you can specify it. For example, when the data comes from csv file, you need to specify the time format.

```
times = data.frame(
    time = c("2023/12/02 07:00", "2023/12/02 07:15", "2023/12/02 07:30", "2023/12/02 07:45",
             "2023/12/02 08:00", "2023/12/02 08:15", "2023/12/02 08:30", "2023/12/02 08:45",
             "2023/12/02 09:00", "2023/12/02 09:15", "2023/12/02 09:30", "2023/12/02 09:45",
             "2023/12/02 10:00", "2023/12/02 10:15", "2023/12/02 10:30", "2023/12/02 10:45",
             "2023/12/02 11:00", "2023/12/02 11:15", "2023/12/02 11:30", "2023/12/02 11:45",
             "2023/12/02 12:00", "2023/12/02 12:15", "2023/12/02 12:30", "2023/12/02 12:45",
             "2023/12/02 13:00", "2023/12/02 13:15", "2023/12/02 13:30", "2023/12/02 13:45"),
    value =  50 + 150 * runif(28)
)

timeDF = as.timeDF(times, format = "%Y/%m/%d %H:%M")
```


## periodDF

There are three types of periodDF. Each period is represented by pairs of times, dates, and times in a day. Labels can be set for each period, and when it is done behaviors of extraction and flagging change.


* time

```
period_time = data.frame(
    start = c("2023-12-02 10:00:00",
              "2023-12-04 10:00:00"),
    end = c("2023-12-02 12:00:00",
            "2023-12-04 12:00:00"),
    label = c("2", "4"))
time_periodDF = as.periodDF(period_time, "time")
time_periodDF_label = as.periodDF(period_time, "time", label_var = "label")
```

* date

```
period_date = data.frame(
    start = c("2023-12-01",
              "2023-12-03"),
    end = c("2023-12-01",
            "2023-12-03"),
    label = c("1", "3")
    )
date_periodDF = as.periodDF(period_date, "date")
date_periodDF_label = as.periodDF(period_date, "date", label_var = "label")
```

* time_in_a_day

```
period_time_in_day = data.frame(
    start = c("10:00",
              "18:00"),
    end = c("12:00",
            "20:00"),
    label = c("m", "e")
    )
time_in_a_day_periodDF = as.periodDF(period_time_in_day, "time_in_a_day")
time_in_a_day_periodDF_label = as.periodDF(period_time_in_day, "time_in_a_day", label_var = "label")
```


## Handle timeDF with periodDF

### 1. Extraction

* extract_with_periodDF(timeDF, periodDF, include, modStart = 0, modEnd = 0, units = NULL, outputAsBool = FALSE)

This function extracts time records from timeDF object that are included within periods of periodDF object.

#### How periods are interpreted

How this function interprets periods of periodDF depends on the following factors.

1. Timescale of periodDF
    * which is specified in periodDF
2. Inclusion of none/either/both side(s)
    * which is specified when extracting time records

Using these factors,

1. For times in perodDF
    + If one of the sides or both sides are not included, the side is adjusted by one second to exclude the side(s).
2. For dates in periodDF
    + If one of the sides or both sides are not included, the side is adjusted by one day to exclude the side(s).
    + After that, for starts, 00:00:00 of the date is used. For ends, 23:59:59 of the date is used.
3. For times in a day in periodDF
    + Internally, Times in a day are dealt as times in seconds from 00:00:00.
    + If one of the sides or both sides are not included, the side is adjusted by one second to exclude the side(s).

modStart and modEnd are added to these values for modification.


#### How outputs are formatted

The output of this function depends on the following factors.

1. Whether periodDF has labels
    * If periodDF does not have labels, timeDF object is returned.
    * If periodDF has labels, a list of timeDF objects with keys of label names is retruned.
2. Whether the output is periodDF or boolean vector
    * When outputAsBool is TRUE, returned objects are boolean vectors or a list of boolean vectors, which correspond to the indices of the original periodDF to be extracted.


#### Examples of how periods of periodDF are interpreted

Depending on the periodDF timescales and include option when extraction, times for starts and ends are interpreted as follows.

modStart and modEnd are added to these time objects when specified.

* Time

"left" option works in many cases.

|         | Start 2023-12-01 04:00:00 | End 2023-12-01 12:00:00 |
|---------|---------------------------|-------------------------|
|None     | 2023-12-01 04:00:01       | 2023-12-01 11:59:59     |
|Left     | 2023-12-01 04:00:00       | 2023-12-01 11:59:59     |
|Right    | 2023-12-01 04:00:01       | 2023-12-01 12:00:00     |
|Both     | 2023-12-01 04:00:00       | 2023-12-01 12:00:00     |


* Date

"both" option works in many cases.

|         | Start 2023-12-01    | End 2023-12-03      |
|---------|---------------------|---------------------|
|None     | 2023-12-02 00:00:00 | 2023-12-02 23:59:59 |
|Left     | 2023-12-01 00:00:00 | 2023-12-02 23:59:59 |
|Right    | 2023-12-02 00:00:00 | 2023-12-03 23:59:59 |
|Both     | 2023-12-01 00:00:00 | 2023-12-03 23:59:59 |

|         | Start 2023-12-01    | End 2023-12-02      |
|---------|---------------------|---------------------|
|None     | NA                  | NA                  |
|Left     | 2023-12-01 00:00:00 | 2023-12-01 23:59:59 |
|Right    | 2023-12-02 00:00:00 | 2023-12-02 23:59:59 |
|Both     | 2023-12-01 00:00:00 | 2023-12-02 23:59:59 |

|         | Start 2023-12-01    | End 2023-12-01      |
|---------|---------------------|---------------------|
|None     | NA                  | NA                  |
|Left     | NA                  | NA                  |
|Right    | NA                  | NA                  |
|Both     | 2023-12-01 00:00:00 | 2023-12-01 23:59:59 |


* Time in a day

"left" option works in many cases.

|         | Start 04:00         | End 12:00           |
|---------|---------------------|---------------------|
|None     | 60 * 60 * 4 + 1     | 60 * 60 * 12 - 1    |
|Left     | 60 * 60 * 4         | 60 * 60 * 12 - 1    |
|Right    | 60 * 60 * 4 + 1     | 60 * 60 * 12        |
|Both     | 60 * 60 * 4         | 60 * 60 * 12        |


### 2. Flagging

* flag_with_periodDF(timeDF, periodDF, flag_var, include, modStart = 0, modEnd = 0, units = NULL)

Flag time records of timeDF object that are included within periods of periodDF object.

Which time records are flagged follows the same rule as extract_with_periodDF function.

When periodDF has labels, the labels are used for flagging. If not, TRUE is used for flagging.

Please note that when a time record of timeDF belongs to mutliple periods of peridDF, which label is assigned is undefined.


## More tools for timeDF

* time_vec(timeDF)

This function returns time vector of timeDF.

* tiem_var(timeDF)

This function retuns the column name of times of timeDF.

* select_timeDF(timeDF, colnames)

This function function returns a new timeDF object with columns
specified and the column holding time information.

* sort_timeDF(timeDF, decreasing=)

This function sorts records of timeDF.

* validate_timeDF(timeDF, noerror=FALSE)

validate_timeDF function checks whether the object is a valid timeDF
object.

* validate\_sorted\_timeDF(timeDF, noerror=FALSE)

validate_timeDF function checks whether the object is a valid sorted
timeDF object.

* as.data.frame(timeDF)

This function converts timeDF to data.frame


## More tools for periodDF

* period_type(periodDF)

This function returns the period type of periodDF.

* vec_to_periodDF(vec, period_type, duration, units, format = "auto", labels = NULL, pre_margin = 0)

This function takes a vector of timepoints or dates  to start and each duration, and constructs periodDF class object.


* adjust_periodDF(periodDF, adjStart, adjEnd, units)

This function adjusts starts and ends for periods in periodDF objects.


* condense_priodDF(periodDF, open = TRUE, useData = "start")

This function condenses periods in a periodDF object. If some periods are overlapped, they are condensed into one period.
When periods share the same timing with their start and end, whether they are combined into one period or are dealt separately depends on an argument of open.


* convert_periodDF(periodDF, period_type, base_date = NULL)

This function converts period types of periodDF object. Conversions from "date" to "time", "time" to "date", "time" to "time_in_a_day" and "time_in_a_day" to "time" are supported.


## Website

https://github.com/niceume/timeDF


## Contact

Your feedback is welcome.

Maintainer: Toshi Umehara toshi@niceume.com

