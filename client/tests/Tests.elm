module Tests exposing (all)

import ElmTest.Extra exposing (Test, describe)


--

import Src.Data.DurationTest
import Src.Util.DateTimeStuffTest
import Src.Util.CalendarTest


all : Test
all =
    describe "Tests"
        [ Src.Data.DurationTest.all
        , Src.Util.DateTimeStuffTest.all
        , Src.Util.CalendarTest.all
        ]
