module View.Calendar exposing (view)

import Date exposing (Date)
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

        appliedClass =
            case day of
                Valid day ->
                    ActiveDay

                Edge day ->
                    EdgeDay
    in
        td
            [ class [ appliedClass ] ]
            [ content day ]


tableHeader : List String -> List (Html msg)
tableHeader =
    List.singleton
        << tr []
        << List.map
            (th [] << List.singleton << text)
