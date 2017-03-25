module Main exposing (..)

import Array
import Date exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import List exposing (singleton, sum)
import Task
import Time exposing (Time)


--

import Css
import Date.Extra.Format exposing (isoDateString)


--

import Data.Duration
import Model exposing (Model)
import Messages exposing (..)
import Style.Global
import Update exposing (update)
import Util.DateTimeStuff exposing (..)
import View.Main


init : ( Model, Cmd Msg )
init =
    ( { startDate = Date.fromTime 0
      , duration = Data.Duration.fromTime oneWeek
      }
    , setStartDateToNow
    )


view : Model -> Html Msg
view model =
    div []
        [ node "Link" [ href "../index.css", type_ "text/css", rel "stylesheet" ] []
        , View.Main.view model
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- TASKS


setStartDateToNow : Cmd Msg
setStartDateToNow =
    Task.perform SetStartDate Date.now



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
