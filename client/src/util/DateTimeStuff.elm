module Util.DateTimeStuff exposing (..)

import Date exposing (Date, Day(..), fromTime, toTime)
import Time exposing (Time)


oneDay : Time
oneDay =
    24 * 60 * 60 * 1000


oneWeek : Time
oneWeek =
    7 * oneDay


duration : Date -> Date -> Float
duration startDate endDate =
    (toTime endDate) - (toTime startDate)


addTime : Time -> Date -> Date
addTime time date =
    fromTime <| (toTime date) + time


addDays : Int -> Date -> Date
addDays numDays date =
    let
        days =
            (toFloat numDays) * oneDay
    in
        addTime days date


addDay : Date -> Date
addDay =
    addTime oneDay


addWeek : Date -> Date
addWeek =
    addTime oneWeek


dateLessThan : Date -> Date -> Bool
dateLessThan a b =
    (toTime a) < (toTime b)


dateRange : Date -> Date -> List Date
dateRange startDate endDate =
    if dateLessThan startDate endDate then
        startDate :: dateRange (addDay startDate) endDate
    else
        [ startDate ]
