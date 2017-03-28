module Src.Util.ColorTest exposing (all)

import ElmTest.Extra exposing (..)
import Expect exposing (Expectation, equal)
import Fuzz exposing (Fuzzer, int, intRange, tuple3)
import Random


--

import Util.Color as Color exposing (red, green, blue)


all : Test
all =
    describe "Util.Color"
        [ rgbColorRange ]


rgbColorRange : Test
rgbColorRange =
    describe "rgbColorBlend"
        [ fuzz3 positive colors colors "returns start color when given index 0" <|
            \steps start end ->
                Color.rgbColorBlend steps start end 0 |> equal start
        , fuzz3 colors colors int "returns start color when given steps 0" <|
            \start end index ->
                Color.rgbColorBlend 0 start end index |> equal start
        , fuzz3 positive colors colors "returns the end color when given an index = (steps + 1)" <|
            \steps start end ->
                let
                    index =
                        steps + 1

                    result =
                        Color.rgbColorBlend steps start end index
                in
                    if steps == 0 then
                        result |> equal start
                    else
                        result |> equal end
        , test "returns index 1 as the mean color given 1 step" <|
            \() ->
                let
                    start =
                        ( 100, 120, 140 )

                    end =
                        ( 200, 121, 255 )

                    expected =
                        ( 150, 120, 197 )

                    result =
                        Color.rgbColorBlend 1 start end 1
                in
                    result |> equal expected
        , fuzz2 colors colors "returns index 1 as the mean color given a step of 1 (fuzz)" <|
            \start end ->
                let
                    avg a b =
                        (+) a <| floor <| toFloat (b - a) / 2

                    expected =
                        ( avg (red start) (red end), avg (green start) (green end), avg (blue start) (blue end) )

                    result =
                        Color.rgbColorBlend 1 start end 1
                in
                    result |> equal expected
        , test "works correctly for a steps of 11 and a verity of ranges" <|
            \() ->
                let
                    start =
                        ( 0, 0, 0 )

                    end =
                        ( 200, 200, 200 )

                    expected =
                        [ ( 0, 0, 0 )
                        , ( 20, 20, 20 )
                        , ( 40, 40, 40 )
                        , ( 60, 60, 60 )
                        , ( 80, 80, 80 )
                        , ( 100, 100, 100 )
                        , ( 120, 120, 120 )
                        , ( 140, 140, 140 )
                        , ( 160, 160, 160 )
                        , ( 180, 180, 180 )
                        , ( 200, 200, 200 )
                        ]

                    colorInterval =
                        Color.rgbColorBlend 9 start end

                    results =
                        List.map colorInterval [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
                in
                    results |> equal expected
        ]



--


positive : Fuzzer Int
positive =
    intRange 0 Random.maxInt


color : Fuzzer Int
color =
    intRange 15 255


colors : Fuzzer ( Int, Int, Int )
colors =
    tuple3 ( color, color, color )
