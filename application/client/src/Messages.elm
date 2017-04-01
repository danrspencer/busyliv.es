module Messages exposing (..)

import Date exposing (Date)


type Msg
    = SelectStartDate String
    | SetStartDate Date
    | SelectEndDate String
