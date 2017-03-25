module Style.Calendar exposing (CssClasses(..), snippet, namespace)

import Css exposing (..)
import Css.Elements exposing (..)
import Css.Namespace
import Html.CssHelpers exposing (withNamespace)


type Namespace
    = Calendar


type CssClasses
    = CalendarTable
    | ActiveDay
    | EdgeDay


namespace =
    withNamespace Calendar


snippet =
    Css.Namespace.namespace Calendar
        [ class CalendarTable
            [ descendants
                [ th headerCell
                , td dayCell
                , class ActiveDay activeDay
                , class EdgeDay edgeDay
                ]
            ]
        ]


headerCell =
    calendarCell
        ++ [ backgroundColor (rgb 170 170 170)
           ]


dayCell =
    calendarCell
        ++ [ backgroundColor (rgb 200 200 200) ]


edgeDay =
    [ color (rgb 150 150 150) ]


activeDay =
    [ hover
        [ backgroundColor (rgb 0 200 200)
        ]
    ]


calendarCell =
    [ textAlign center
    , width (25 |> px)
    ]
