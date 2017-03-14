module Main exposing (..)

import Array
import Date exposing (..)
import Date.Extra.Format as Format exposing (isoDateString)
import Html exposing (..)
import Html.Attributes exposing (type_, value)
import Html.Events exposing (onInput)
import List exposing (sum)
import Task
import Time exposing (Time)


-- PROJECT IMPORTS

import DateTimeStuff exposing (..)


-- MODEL


type alias Model =
    { startDate : Date
    , duration : Float
    }


init : ( Model, Cmd Msg )
init =
    ( { startDate = Date.fromTime 0
      , duration = oneWeek
      }
    , setStartDateToNow
    )



-- MESSAGES


type Msg
    = SelectStartDate String
    | SetStartDate Date
    | SelectEndDate String



-- VIEW


toListItem : a -> Html Msg
toListItem =
    li []
        << List.singleton
        << text
        << toString


view : Model -> Html Msg
view model =
    let
        endDate =
            addTime model.duration model.startDate
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
            , br [] []
            , br [] []
            , br [] []
            , table []
                [ tr []
                    [ th [] [ text "S" ]
                    , th [] [ text "M" ]
                    , th [] [ text "T" ]
                    , th [] [ text "W" ]
                    , th [] [ text "T" ]
                    , th [] [ text "F" ]
                    , th [] [ text "S" ]
                    ]
                ]
            , br [] []
            , br [] []
            , br [] []
            , ul [] <|
                List.map
                    (toListItem << isoDateString)
                    (dateList model.startDate endDate)
            ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectStartDate startDateString ->
            ( { model | startDate = parseDate startDateString }, Cmd.none )

        SetStartDate startDate ->
            ( { model | startDate = startDate }, Cmd.none )

        SelectEndDate endDateString ->
            ( { model | duration = calcDuration model.startDate endDateString }, Cmd.none )



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
