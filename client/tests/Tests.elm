module Tests exposing (all)

import ElmTest.Extra exposing (Test, describe)


--

import Src.DateTimeStuffTest
import Src.CalendarTest


all : Test
all =
    describe "Tests"
        [ Src.DateTimeStuffTest.all
        , Src.CalendarTest.all
        ]
