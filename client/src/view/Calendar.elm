module View.Calendar exposing (view)

import Date exposing (Date, Month(..))
import Html exposing (..)
import Html.Attributes exposing (style)


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
            [ thead [] <| tableHeader [ "S", "M", "T", "W", "T", "F", "S", "" ]
            , tbody [] <| List.map weekRow (Calendar.generate dates)
            ]


weekRow : List CalendarDay -> Html msg
weekRow days =
    tr [] <| (List.map dayCell days) ++ [ monthNameCell days ]


monthNameCell : List CalendarDay -> Html msg
monthNameCell days =
    let
        firstDay =
            List.head << List.filter ((==) 1 << Date.day << justDate)
    in
        case firstDay days of
            Just day ->
                td
                    [ class [ MonthNameColumn, getMonthCssClass day ] ]
                    [ text <| toString <| Date.month <| justDate day ]

            Nothing ->
                td [ class [ MonthNameColumn ] ] []


dayCell : CalendarDay -> Html msg
dayCell day =
    let
        content =
            text << toString << Date.day << justDate

        dayClass day =
            case day of
                Valid day ->
                    ActiveDay

                Edge day ->
                    EdgeDay

        classes day =
            class [ (getMonthCssClass day), (dayClass day) ]
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


getMonthCssClass : CalendarDay -> CssClasses
getMonthCssClass date =
    case Date.month <| justDate date of
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
