module View.Calendar exposing (view)

import Date
import Html exposing (..)
import Html.Attributes exposing (..)


--

import Calendar
import Style.Calendar exposing (style, calendar)
import DateTimeStuff exposing (..)
import Model exposing (Model)


--


view : Model -> Html msg
view model =
    let
        endDate =
            addTime model.duration model.startDate

        dates =
            dateList model.startDate endDate
    in
        table [ Style.Calendar.style calendar ] <|
            (tr []
                [ th [] [ text "S" ]
                , th [] [ text "M" ]
                , th [] [ text "T" ]
                , th [] [ text "W" ]
                , th [] [ text "T" ]
                , th [] [ text "F" ]
                , th [] [ text "S" ]
                ]
            )
                :: List.map
                    (toRow <| toString << Date.day)
                    (Calendar.generate dates)


toCell : (a -> String) -> Maybe a -> Html msg
toCell formatter value =
    td [] <|
        case value of
            Just value ->
                List.singleton <|
                    text <|
                        formatter value

            Nothing ->
                []


toRow : (a -> String) -> List (Maybe a) -> Html msg
toRow cellFormatter values =
    tr [] <|
        List.map
            (toCell cellFormatter)
            (values)
