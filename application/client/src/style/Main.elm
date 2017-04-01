module Style.Main exposing (styles)

import List exposing (map)


--

import Css exposing (stylesheet)


--

import Style.Calendar
import Style.Global


--


styles : List Css.Stylesheet
styles =
    [ Style.Global.snippet
    , Style.Calendar.snippet
    ]
        |> map stylesheet
