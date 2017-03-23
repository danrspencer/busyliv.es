module Style.Calendar exposing (..)

import Html
import Html.Attributes exposing (..)
import Css exposing (..)
import Css.Elements exposing (..)


style : List Mixin -> Html.Attribute msg
style =
    Css.asPairs >> Html.Attributes.style


calendar : List Mixin
calendar =
    [ backgroundColor (rgb 255 0 0)
    , border2 (px 1) solid
    ]
