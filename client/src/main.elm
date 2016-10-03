module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import String
import Date exposing (Date, now)


main =
    App.beginnerProgram { model = model, view = view, update = update }


type alias Model =
    { name : String
    , location : String
    , start : Date
    , end : Date
    }


model : Model
model =
    Model "" "" Date.fromString("") Date.fromString("")


type Msg
    = Name String
    | Location String
    | Start Date
    | End Date


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Location location ->
            { model | location = location }

        Start start ->
            { model | start = start }

        End end ->
            { model | end = end }


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ input [ placeholder "event name", onInput Name ] []
            ]
        , div []
            [ input [ placeholder "location", onInput Name ] []
            ]
        , div []
            [ input [ placeholder "start date", type' "date", onInput Name ] []
            ]
        , div []
            [ input [ placeholder "end date", type' "date", onInput Name ] []
            ]
        ]
