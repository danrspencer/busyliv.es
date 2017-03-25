module Model exposing (Model)

import Date exposing (Date)
import Time exposing (Time)


--

import Data.Duration exposing (Duration)


--


type alias Model =
    { startDate : Date
    , duration : Duration
    }
