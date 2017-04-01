module Tests exposing (all)

import ElmTest.Extra exposing (Test, describe)


--

import Src.Data.DurationTest
import Src.Util.DateTimeStuffTest
import Src.Util.CalendarTest
import Src.Util.ColorTest


all : Test
all =
    describe "Tests"
        [ Src.Data.DurationTest.all
        , Src.Util.CalendarTest.all
        , Src.Util.ColorTest.all
        , Src.Util.DateTimeStuffTest.all
        ]
