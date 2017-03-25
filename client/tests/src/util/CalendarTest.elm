module Src.Util.CalendarTest exposing (all)

import Date exposing (Date)
import Expect exposing (Expectation, equal)
import ElmTest.Extra exposing (..)


--

import Util.Calendar as Calendar exposing (CalendarDay(..))
import Util.DateTimeStuff as DateTimeStuff exposing (..)


all : Test
all =
    describe "Calendar"
        [ generate ]


generate : Test
generate =
    describe "generate"
        [ test "returns a week in a nested list" <|
            \() ->
                let
                    end =
                        6 |> daysFrom sunday

                    dates =
                        dateRange sunday end

                    result =
                        Calendar.generate dates

                    expected =
                        [ [ Valid (0 |> daysFrom sunday)
                          , Valid (1 |> daysFrom sunday)
                          , Valid (2 |> daysFrom sunday)
                          , Valid (3 |> daysFrom sunday)
                          , Valid (4 |> daysFrom sunday)
                          , Valid (5 |> daysFrom sunday)
                          , Valid (6 |> daysFrom sunday)
                          ]
                        ]
                in
                    expected |> equal result
        , test "if the dates start midweek it pads with Edge dates" <|
            \() ->
                let
                    end =
                        3 |> daysFrom wednesday

                    dates =
                        dateRange wednesday end

                    result =
                        Calendar.generate dates

                    expected =
                        [ [ Edge (-3 |> daysFrom wednesday)
                          , Edge (-2 |> daysFrom wednesday)
                          , Edge (-1 |> daysFrom wednesday)
                          , Valid (0 |> daysFrom wednesday)
                          , Valid (1 |> daysFrom wednesday)
                          , Valid (2 |> daysFrom wednesday)
                          , Valid (3 |> daysFrom wednesday)
                          ]
                        ]
                in
                    expected |> equal result
        , test "if the dates end midweek it pads with Edge dates" <|
            \() ->
                let
                    end =
                        3 |> daysFrom sunday

                    dates =
                        dateRange sunday end

                    result =
                        Calendar.generate dates

                    expected =
                        [ [ Valid (0 |> daysFrom sunday)
                          , Valid (1 |> daysFrom sunday)
                          , Valid (2 |> daysFrom sunday)
                          , Valid (3 |> daysFrom sunday)
                          , Edge (4 |> daysFrom sunday)
                          , Edge (5 |> daysFrom sunday)
                          , Edge (6 |> daysFrom sunday)
                          ]
                        ]
                in
                    expected |> equal result
        , test "if given an empty list it returns an empty list" <|
            \() ->
                Calendar.generate [] |> equal []
        , test "it splits two weeks over two lines" <|
            \() ->
                let
                    end =
                        sunday |> addTime (13 * oneDay)

                    dates =
                        dateRange sunday end

                    result =
                        Calendar.generate dates

                    expected =
                        [ [ Valid (0 |> daysFrom sunday)
                          , Valid (1 |> daysFrom sunday)
                          , Valid (2 |> daysFrom sunday)
                          , Valid (3 |> daysFrom sunday)
                          , Valid (4 |> daysFrom sunday)
                          , Valid (5 |> daysFrom sunday)
                          , Valid (6 |> daysFrom sunday)
                          ]
                        , [ Valid (7 |> daysFrom sunday)
                          , Valid (8 |> daysFrom sunday)
                          , Valid (9 |> daysFrom sunday)
                          , Valid (10 |> daysFrom sunday)
                          , Valid (11 |> daysFrom sunday)
                          , Valid (12 |> daysFrom sunday)
                          , Valid (13 |> daysFrom sunday)
                          ]
                        ]
                in
                    expected |> equal result
        , test "creates a correct calendar structure for arbtary start end dates" <|
            \() ->
                let
                    end =
                        millennium |> addTime (18 * oneDay)

                    dates =
                        dateRange millennium end

                    result =
                        Calendar.generate dates

                    expected =
                        [ [ Edge (-6 |> daysFrom millennium)
                          , Edge (-5 |> daysFrom millennium)
                          , Edge (-4 |> daysFrom millennium)
                          , Edge (-3 |> daysFrom millennium)
                          , Edge (-2 |> daysFrom millennium)
                          , Edge (-1 |> daysFrom millennium)
                          , Valid (0 |> daysFrom millennium)
                          ]
                        , [ Valid (1 |> daysFrom millennium)
                          , Valid (2 |> daysFrom millennium)
                          , Valid (3 |> daysFrom millennium)
                          , Valid (4 |> daysFrom millennium)
                          , Valid (5 |> daysFrom millennium)
                          , Valid (6 |> daysFrom millennium)
                          , Valid (7 |> daysFrom millennium)
                          ]
                        , [ Valid (8 |> daysFrom millennium)
                          , Valid (9 |> daysFrom millennium)
                          , Valid (10 |> daysFrom millennium)
                          , Valid (11 |> daysFrom millennium)
                          , Valid (12 |> daysFrom millennium)
                          , Valid (13 |> daysFrom millennium)
                          , Valid (14 |> daysFrom millennium)
                          ]
                        , [ Valid (15 |> daysFrom millennium)
                          , Valid (16 |> daysFrom millennium)
                          , Valid (17 |> daysFrom millennium)
                          , Valid (18 |> daysFrom millennium)
                          , Edge (19 |> daysFrom millennium)
                          , Edge (20 |> daysFrom millennium)
                          , Edge (21 |> daysFrom millennium)
                          ]
                        ]
                in
                    expected |> equal result
        ]



-- HELPERS


daysFrom : Date -> Int -> Date
daysFrom date days =
    addDays days date


millennium : Date
millennium =
    Date.fromTime (946684800 * 1000)


sunday : Date
sunday =
    1 |> daysFrom millennium


wednesday : Date
wednesday =
    4 |> daysFrom millennium
