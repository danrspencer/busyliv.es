module Update exposing (update)

import Date exposing (Date)
import Result exposing (toMaybe, withDefault)
import Time exposing (Time)


--

import Data.Duration exposing (Duration)
import Messages exposing (..)
import Model exposing (Model)
import Util.DateTimeStuff exposing (duration)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectStartDate start ->
            ( { model
                | startDate =
                    Date.fromString start |> withDefault model.startDate
              }
            , Cmd.none
            )

        SetStartDate startDate ->
            ( { model | startDate = startDate }, Cmd.none )

        SelectEndDate end ->
            ( { model
                | duration = calcDuration model.startDate end |> withDefault model.duration
              }
            , Cmd.none
            )


calcDuration : Date -> String -> Result String Duration
calcDuration startDate end =
    case Date.fromString end |> toMaybe of
        Just endDate ->
            Ok <| Data.Duration.fromTime <| duration startDate endDate

        Nothing ->
            Err end
