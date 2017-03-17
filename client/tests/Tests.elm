module Tests exposing (all)

import ElmTest.Extra exposing (Test, describe)
import Src.DateTimeStuffTest as DateTimeStuff


all : Test
all =
    describe "Tests"
        [ DateTimeStuff.all
        ]
