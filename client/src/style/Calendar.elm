module Style.Calendar exposing (CssClasses(..), snippet, namespace)

import Css exposing (..)
import Css.Elements exposing (..)
import Css.Namespace
import Html.CssHelpers exposing (withNamespace)


--

import Style.Colors as Colors exposing (months)


type Namespace
    = Calendar


type CssClasses
    = CalendarTable
    | ActiveDay
    | EdgeDay
    | MonthJan
    | MonthFeb
    | MonthMar
    | MonthApr
    | MonthMay
    | MonthJun
    | MonthJul
    | MonthAug
    | MonthSep
    | MonthOct
    | MonthNov
    | MonthDec


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
                , class MonthJan [ backgroundColor months.jan ]
                , class MonthFeb [ backgroundColor months.feb ]
                , class MonthMar [ backgroundColor months.mar ]
                , class MonthApr [ backgroundColor months.apr ]
                , class MonthMay [ backgroundColor months.may ]
                , class MonthJun [ backgroundColor months.jun ]
                , class MonthJul [ backgroundColor months.jul ]
                , class MonthAug [ backgroundColor months.aug ]
                , class MonthSep [ backgroundColor months.sep ]
                , class MonthOct [ backgroundColor months.oct ]
                , class MonthNov [ backgroundColor months.nov ]
                , class MonthDec [ backgroundColor months.dec ]
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
