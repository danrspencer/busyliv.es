module View.Main exposing (view)

import Html exposing (..)


--

import View.Calendar as Calendar
import View.StartEndPicker as StartEndPicker


--

import Model exposing (Model)
import Messages exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ StartEndPicker.view model
        , Calendar.view model
        ]
