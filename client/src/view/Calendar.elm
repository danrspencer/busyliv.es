module View.Calendar exposing (view)

import Date exposing (Date, Month(..))
import Html exposing (..)
import Html.Attributes


--

import Data.Duration exposing (toTime)
import Model exposing (Model)
import Style.Calendar exposing (CssClasses(..))
import Util.Calendar as Calendar exposing (CalendarDay(..), justDate)
import Util.DateTimeStuff exposing (..)


{ class } =
    Style.Calendar.namespace



--


view : Model -> Html msg
view model =
    let
        endDate =
            model.startDate |> addTime (toTime model.duration)

        dates =
            dateRange model.startDate endDate
    in
        table [ class [ CalendarTable ] ]
            [ thead [] <| tableHeader [ "S", "M", "T", "W", "T", "F", "S" ]
            , tbody [] <| List.map toWeekRow (Calendar.generate dates)
            ]


toWeekRow : List CalendarDay -> Html msg
toWeekRow values =
    tr [] <|
        List.map toDayCell values


toDayCell : CalendarDay -> Html msg
toDayCell day =
    let
        content =
            text << toString << Date.day << justDate

        monthClass =
            getMonthClass << justDate

        dayClass day =
            case day of
                Valid day ->
                    ActiveDay

                Edge day ->
                    EdgeDay

        classes day =
            class [ (monthClass day), (dayClass day) ]
    in
        td
            [ classes day ]
            [ content day ]


tableHeader : List String -> List (Html msg)
tableHeader =
    List.singleton
        << tr []
        << List.map
            (th [] << List.singleton << text)


getMonthClass : Date -> CssClasses
getMonthClass date =
    case Date.month date of
        Jan ->
            MonthJan

        Feb ->
            MonthFeb

        Mar ->
            MonthMar

        Apr ->
            MonthApr

        May ->
            MonthMay

        Jun ->
            MonthJun

        Jul ->
            MonthJul

        Aug ->
            MonthAug

        Sep ->
            MonthSep

        Oct ->
            MonthOct

        Nov ->
            MonthNov

        Dec ->
            MonthDec
