module Model exposing (Model)

import Date exposing (Date)


type alias Model =
    { startDate : Date
    , duration : Float
    }
