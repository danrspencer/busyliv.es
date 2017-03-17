module DateTimeStuff exposing (..)

import Date exposing (Date, Day(..), fromTime, toTime)
import Result exposing (withDefault)
import Time exposing (Time)


-- TIME UNITS


oneDay : Time
oneDay =
    24 * 60 * 60 * 1000


oneWeek : Time
oneWeek =
    7 * oneDay



-- FUNCTIONS


parseDate : String -> Date
parseDate =
    Date.fromString
        >> withDefault (Date.fromTime 0)


duration : Date -> Date -> Float
duration startDate endDate =
    (toTime endDate) - (toTime startDate)


calcDuration : Date -> String -> Float
calcDuration startDate endDateString =
    duration startDate <| parseDate endDateString


addTime : Time -> Date -> Date
addTime time date =
    fromTime <| (toTime date) + time


addDay : Date -> Date
addDay =
    addTime oneDay


addWeek : Date -> Date
addWeek =
    addTime oneWeek


dateLessThan : Date -> Date -> Bool
dateLessThan a b =
    (toTime a) < (toTime b)


dateList : Date -> Date -> List Date
dateList startDate endDate =
    if dateLessThan startDate endDate then
        startDate :: dateList (addDay startDate) endDate
    else
        [ startDate ]


dayPosition : Date.Day -> Int
dayPosition day =
    case day of
        Sun ->
            0

        Mon ->
            1

        Tue ->
            2

        Wed ->
            3

        Thu ->
            4

        Fri ->
            5

        Sat ->
            6


padCalendarRow : List Date -> List (Maybe Date)
padCalendarRow dates =
    case List.head dates of
        Just date ->
            if Date.dayOfWeek date /= Sun then
                Nothing
                    :: List.map
                        Just
                        dates
            else
                List.map
                    Just
                    dates

        Nothing ->
            []


generateCalendar : List Date -> List (List (Maybe Date))
generateCalendar dates =
    [ padCalendarRow dates
    ]



----    List.foldl
----        (\( date, calendar ) -> [])
----        []
