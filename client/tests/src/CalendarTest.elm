module Src.CalendarTest exposing (all)

import Date exposing (Date)
import Expect exposing (Expectation, equal)
import Maybe exposing (andThen, withDefault)
import ElmTest.Extra exposing (..)


--

import Calendar
import DateTimeStuff exposing (..)


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
                    aSunday =
                        millennium |> addDay

                    end =
                        aSunday |> addTime (6 * oneDay)

                    dates =
                        dateList aSunday end

                    result =
                        Calendar.generate dates

                    expected =
                        [ [ aSunday |> addTime (0 * oneDay) |> Just
                          , aSunday |> addTime (1 * oneDay) |> Just
                          , aSunday |> addTime (2 * oneDay) |> Just
                          , aSunday |> addTime (3 * oneDay) |> Just
                          , aSunday |> addTime (4 * oneDay) |> Just
                          , aSunday |> addTime (5 * oneDay) |> Just
                          , aSunday |> addTime (6 * oneDay) |> Just
                          ]
                        ]
                in
                    expected |> equal result
        , test "if the dates start midweek it pads with Nothings" <|
            \() ->
                let
                    aWednesday =
                        millennium |> addTime (4 * oneDay)

                    end =
                        aWednesday |> addTime (3 * oneDay)

                    dates =
                        dateList aWednesday end

                    result =
                        Calendar.generate dates

                    expected =
                        [ [ Nothing
                          , Nothing
                          , Nothing
                          , aWednesday |> addTime (0 * oneDay) |> Just
                          , aWednesday |> addTime (1 * oneDay) |> Just
                          , aWednesday |> addTime (2 * oneDay) |> Just
                          , aWednesday |> addTime (3 * oneDay) |> Just
                          ]
                        ]
                in
                    expected |> equal result
        , test "if the dates end midweek it pads with Nothings" <|
            \() ->
                let
                    aWednesday =
                        millennium |> addTime (4 * oneDay)

                    end =
                        aWednesday |> addTime (2 * oneDay)

                    dates =
                        dateList aWednesday end

                    result =
                        Calendar.generate dates

                    expected =
                        [ [ Nothing
                          , Nothing
                          , Nothing
                          , aWednesday |> addTime (0 * oneDay) |> Just
                          , aWednesday |> addTime (1 * oneDay) |> Just
                          , aWednesday |> addTime (2 * oneDay) |> Just
                          , Nothing
                          ]
                        ]
                in
                    expected |> equal result
        , test "if given an empty list it returns 7 x nothing" <|
            \() ->
                let
                    result =
                        Calendar.generate []

                    expected =
                        [ [ Nothing
                          , Nothing
                          , Nothing
                          , Nothing
                          , Nothing
                          , Nothing
                          , Nothing
                          ]
                        ]
                in
                    expected |> equal result
        , test "it splits two weeks over two lines" <|
            \() ->
                let
                    aSunday =
                        millennium |> addDay

                    end =
                        aSunday |> addTime (13 * oneDay)

                    dates =
                        dateList aSunday end

                    result =
                        Calendar.generate dates

                    expected =
                        [ [ aSunday |> addTime (0 * oneDay) |> Just
                          , aSunday |> addTime (1 * oneDay) |> Just
                          , aSunday |> addTime (2 * oneDay) |> Just
                          , aSunday |> addTime (3 * oneDay) |> Just
                          , aSunday |> addTime (4 * oneDay) |> Just
                          , aSunday |> addTime (5 * oneDay) |> Just
                          , aSunday |> addTime (6 * oneDay) |> Just
                          ]
                        , [ aSunday |> addTime (7 * oneDay) |> Just
                          , aSunday |> addTime (8 * oneDay) |> Just
                          , aSunday |> addTime (9 * oneDay) |> Just
                          , aSunday |> addTime (10 * oneDay) |> Just
                          , aSunday |> addTime (11 * oneDay) |> Just
                          , aSunday |> addTime (12 * oneDay) |> Just
                          , aSunday |> addTime (13 * oneDay) |> Just
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
                        dateList millennium end

                    result =
                        Calendar.generate dates

                    expected =
                        [ [ Nothing
                          , Nothing
                          , Nothing
                          , Nothing
                          , Nothing
                          , Nothing
                          , millennium |> addTime (0 * oneDay) |> Just
                          ]
                        , [ millennium |> addTime (1 * oneDay) |> Just
                          , millennium |> addTime (2 * oneDay) |> Just
                          , millennium |> addTime (3 * oneDay) |> Just
                          , millennium |> addTime (4 * oneDay) |> Just
                          , millennium |> addTime (5 * oneDay) |> Just
                          , millennium |> addTime (6 * oneDay) |> Just
                          , millennium |> addTime (7 * oneDay) |> Just
                          ]
                        , [ millennium |> addTime (8 * oneDay) |> Just
                          , millennium |> addTime (9 * oneDay) |> Just
                          , millennium |> addTime (10 * oneDay) |> Just
                          , millennium |> addTime (11 * oneDay) |> Just
                          , millennium |> addTime (12 * oneDay) |> Just
                          , millennium |> addTime (13 * oneDay) |> Just
                          , millennium |> addTime (14 * oneDay) |> Just
                          ]
                        , [ millennium |> addTime (15 * oneDay) |> Just
                          , millennium |> addTime (16 * oneDay) |> Just
                          , millennium |> addTime (17 * oneDay) |> Just
                          , millennium |> addTime (18 * oneDay) |> Just
                          , Nothing
                          , Nothing
                          , Nothing
                          ]
                        ]
                in
                    expected |> equal result
        ]



-- HELPERS


millennium : Date
millennium =
    Date.fromTime (946684800 * 1000)
