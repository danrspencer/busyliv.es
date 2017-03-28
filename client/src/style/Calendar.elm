module Style.Calendar exposing (CssClasses(..), snippet, namespace)

import Css exposing (..)
import Css.Elements exposing (..)
import Css.Namespace
import Html.CssHelpers exposing (withNamespace)


--

import Style.Colors as Colors
import Util.Color exposing (..)


--


type Namespace
    = Calendar


type CssClasses
    = CalendarTable
    | ActiveDay
    | EdgeDay
    | MonthNameColumn
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
                , class MonthNameColumn [ width (40 |> px), fontWeight bold ]
                , class MonthJan [ backgroundColor <| winterToSpring 0 ]
                , class MonthFeb [ backgroundColor <| winterToSpring 1 ]
                , class MonthMar [ backgroundColor <| winterToSpring 2 ]
                , class MonthApr [ backgroundColor <| springToSummer 0 ]
                , class MonthMay [ backgroundColor <| springToSummer 1 ]
                , class MonthJun [ backgroundColor <| springToSummer 2 ]
                , class MonthJul [ backgroundColor <| summerToAutumn 0 ]
                , class MonthAug [ backgroundColor <| summerToAutumn 1 ]
                , class MonthSep [ backgroundColor <| summerToAutumn 2 ]
                , class MonthOct [ backgroundColor <| autumnToWinter 0 ]
                , class MonthNov [ backgroundColor <| autumnToWinter 1 ]
                , class MonthDec [ backgroundColor <| autumnToWinter 2 ]
                ]
            ]
        ]


headerCell =
    calendarCell
        ++ [ backgroundColor (rgb 230 230 230)
           ]


dayCell =
    calendarCell
        ++ [ backgroundColor (rgb 230 230 230) ]


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



--


twoStepBlend : Color -> Color -> (Int -> Color)
twoStepBlend a b =
    let
        alpha =
            0.25

        fromCssColor color =
            ( color.red, color.green, color.blue )

        toRgba ( red, green, blue ) =
            rgba red green blue alpha
    in
        toRgba << rgbColorBlend 2 (fromCssColor a) (fromCssColor b)


winterToSpring : Int -> Color
winterToSpring =
    twoStepBlend Colors.winter Colors.spring


springToSummer : Int -> Color
springToSummer =
    twoStepBlend Colors.spring Colors.summer


summerToAutumn : Int -> Color
summerToAutumn =
    twoStepBlend Colors.summer Colors.autumn


autumnToWinter : Int -> Color
autumnToWinter =
    twoStepBlend Colors.autumn Colors.winter
