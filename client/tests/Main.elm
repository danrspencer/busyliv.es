port module Main exposing (..)

import Test.Runner.Node exposing (run, TestProgram)
import Json.Encode exposing (Value)


-- TESTS

import Src.Tests as Tests
import Src.DateTimeStuffTest as DateTimeStuff


main : TestProgram
main =
    run emit DateTimeStuff.all


port emit : ( String, Value ) -> Cmd msg
