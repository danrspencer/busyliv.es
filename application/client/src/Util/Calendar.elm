module Util.Calendar exposing (CalendarDay(..), generate, justDate)

import Date exposing (Date, Day(..))


--

import Util.DateTimeStuff exposing (addTime, oneDay, dateRange)


type CalendarDay
    = Valid Date
    | Edge Date


justDate : CalendarDay -> Date
justDate day =
    case day of
        Valid day ->
            day

        Edge day ->
            day


generate : List Date -> List (List CalendarDay)
generate =
    padCalendar >> splitToWeeks


padCalendar : List Date -> List CalendarDay
padCalendar dates =
    case
        ( List.head dates
        , List.head <| List.foldl (::) [] dates
        )
    of
        ( Just start, Just end ) ->
            [ padStart start
            , List.map Valid dates
            , padEnd end
            ]
                |> List.concat

        default ->
            []


splitToWeeks : List CalendarDay -> List (List CalendarDay)
splitToWeeks dates =
    case List.isEmpty dates of
        False ->
            (List.take 7 dates)
                :: splitToWeeks (List.drop 7 dates)

        True ->
            []


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


padStart : Date -> List CalendarDay
padStart day =
    let
        timeFromStart =
            Date.dayOfWeek day
                |> dayPosition
                |> (-) 0
                |> toFloat
                |> (*) oneDay

        startOfWeek =
            addTime timeFromStart day

        previousDay =
            addTime (-1 * oneDay) day
    in
        if timeFromStart /= 0 then
            List.map Edge <|
                dateRange startOfWeek previousDay
        else
            []


padEnd : Date -> List CalendarDay
padEnd day =
    let
        timeFromEnd =
            Date.dayOfWeek day
                |> dayPosition
                |> (-) 6
                |> toFloat
                |> (*) oneDay

        endOfWeek =
            addTime timeFromEnd day

        nextDay =
            addTime (1 * oneDay) day
    in
        if timeFromEnd /= 0 then
            List.map Edge <|
                dateRange nextDay endOfWeek
        else
            []
