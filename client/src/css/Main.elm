module Css.Main exposing (..)

import Css exposing (..)
import Css.Elements exposing (body, li)
import Css.Namespace exposing (namespace)


type CssClasses
    = NavBar


type CssIds
    = Page


css =
    (stylesheet << namespace "calendar")
        [ body
            [ overflowX auto
            , minWidth (px 1280)
            ]
        ]
