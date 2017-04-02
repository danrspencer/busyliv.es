module View.StartEndPicker exposing (view)

import Html exposing (..)
import Html.Attributes exposing (type_, value)
import Html.Events exposing (onInput)


--

import Date.Extra.Format exposing (isoDateString)


--

import Data.Duration exposing (toTime)
import Model exposing (Model)
import Messages exposing (..)
import Util.DateTimeStuff exposing (..)


--


view : Model -> Html Msg
view model =
    let
        endDate =
            model.startDate |> addTime (toTime model.duration)
    in
        div []
            [ input
                [ type_ "date"
                , value <| isoDateString model.startDate
                , onInput SelectStartDate
                ]
                []
            , input
                [ type_ "date"
                , value <| isoDateString endDate
                , onInput SelectEndDate
                ]
                []
            ]
