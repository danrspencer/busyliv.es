module Src.DateTimeStuffTest exposing (..)

import Date
import Time
import Test exposing (..)
import Expect
import Fuzz exposing (intRange)


--

import DateTimeStuff


all : Test
all =
    describe "DateTimeStuff"
        [ parseDate, duration, addTime, dateLessThan ]


parseDate : Test
parseDate =
    describe "parseDate"
        [ test "returns epoch time 0 if given an invalid date" <|
            \() ->
                let
                    result =
                        DateTimeStuff.parseDate "not a valid date"
                in
                    Expect.equal (Date.toTime result) 0
        , test "returns the correct date for a valid date string" <|
            \() ->
                let
                    result =
                        DateTimeStuff.parseDate "01-01-2000"

                    millennium =
                        946684800 * 1000
                in
                    Expect.equal (Date.toTime result) millennium
        ]


duration : Test
duration =
    describe "duration"
        [ fuzz2
            (intRange 0 100000000)
            (intRange 0 100000000)
            "calculates the millisconds between two dates"
          <|
            \a b ->
                let
                    timeA =
                        toFloat a

                    timeB =
                        toFloat (a + b)

                    dateA =
                        Date.fromTime timeA

                    dateB =
                        Date.fromTime timeB

                    duration =
                        DateTimeStuff.duration dateA dateB
                in
                    Expect.equal duration (timeB - timeA)
        ]


addTime : Test
addTime =
    describe "addTime"
        [ fuzz2
            (intRange 0 100000000)
            (intRange 0 100000000)
            "adds a specific amount of time onto a date"
          <|
            \a b ->
                let
                    time =
                        toFloat a

                    date =
                        Date.fromTime <| toFloat b

                    newDate =
                        DateTimeStuff.addTime time date
                in
                    Expect.equal (Date.toTime newDate) (time + Date.toTime date)
        ]


dateLessThan : Test
dateLessThan =
    describe "dateLessThan"
        [ fuzz2
            (intRange 0 100000000)
            (intRange 100000001 200000000)
            "asserts that dateA is less than dateB"
          <|
            \a b ->
                let
                    dateA =
                        Date.fromTime <| toFloat a

                    dateB =
                        Date.fromTime <| toFloat b
                in
                    Expect.true "dateA is less than dateB" <| DateTimeStuff.dateLessThan dateA dateB
        , fuzz2
            (intRange 100000001 200000000)
            (intRange 0 100000000)
            "asserts that dateA is not less than dateB"
          <|
            \a b ->
                let
                    dateA =
                        Date.fromTime <| toFloat a

                    dateB =
                        Date.fromTime <| toFloat b
                in
                    Expect.false "dateA is not less than dateB" <| DateTimeStuff.dateLessThan dateA dateB
        , test "equal dates are not less than" <|
            \() ->
                let
                    dateA =
                        Date.fromTime 100000000

                    dateB =
                        Date.fromTime 100000000
                in
                    Expect.false "dateA is not less than dateB" <| DateTimeStuff.dateLessThan dateA dateB
        ]


dateList : Test
dateList =
    describe "dateList"
        []