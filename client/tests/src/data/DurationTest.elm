module Src.Data.DurationTest exposing (all)

import Expect exposing (Expectation, equal)
import Fuzz exposing (Fuzzer, float, floatRange, int, intRange)
import Random exposing (maxInt)


--

import ElmTest.Extra exposing (..)


--

import Data.Duration exposing (..)


all : Test
all =
    describe "Data.Duration"
        [ fuzz negativeFloat "returns 0 when given a duration less than 0" <|
            \a ->
                let
                    duration =
                        fromTime a
                in
                    toTime duration |> Expect.equal 0
        , fuzz (floatRange oneYear <| 10 * oneYear) "returns 0 when given a duration less than 0" <|
            \a ->
                let
                    duration =
                        fromTime a
                in
                    toTime duration |> Expect.equal oneYear
        , fuzz float "works with a range of numbers" <|
            \a ->
                let
                    duration =
                        fromTime a
                in
                    if a < 0 then
                        toTime duration |> Expect.equal 0
                    else if a > oneYear then
                        toTime duration |> Expect.equal oneYear
                    else
                        toTime duration |> Expect.equal a
        ]



--


negativeFloat : Fuzzer Float
negativeFloat =
    floatRange (toFloat maxInt |> (*) -1) 0


oneYear : Float
oneYear =
    31536000000
