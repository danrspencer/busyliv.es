module Src.DateTimeStuffTest exposing (..)

import Date exposing (Date)
import Expect
import Fuzz exposing (intRange)
import List
import Maybe exposing (andThen, withDefault)
import Test exposing (..)
import Time


--

import DateTimeStuff exposing (oneDay, oneWeek)


all : Test
all =
    describe "DateTimeStuff"
        [ parseDate, duration, addTime, dateLessThan, dateList ]


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
                in
                    Expect.equal result millennium
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
        [ test "returns a list with the first element as the start date" <|
            \() ->
                let
                    end =
                        DateTimeStuff.addTime 100000 millennium

                    result =
                        DateTimeStuff.dateList millennium end
                in
                    case List.head result of
                        Just firstResult ->
                            Expect.equal (firstResult) millennium

                        Nothing ->
                            Expect.fail "No dates in list"
        , test "each element should be one day after the previous" <|
            \() ->
                let
                    end =
                        DateTimeStuff.addTime oneWeek millennium

                    result =
                        DateTimeStuff.dateList millennium end

                    resultPairs =
                        toPairs result

                    firstDatePlusDay =
                        Tuple.first >> DateTimeStuff.addTime oneDay
                in
                    resultPairs
                        |> Expect.all
                            [ \pairs -> Expect.equal
                            ]
        ]



-- HELPERS


millennium : Date
millennium =
    Date.fromTime (946684800 * 1000)


roundToDay : Date -> Date
roundToDay date =
    (Date.fromString <|
        String.concat
            [ toString <| Date.year date
            , "-"
            , toString <| Date.month date
            , "-"
            , toString <| Date.day date
            ]
    )
        |> Result.withDefault (Date.fromTime 0)


expectDayEqual : Date -> Date -> Expect.Expectation
expectDayEqual a b =
    Expect.equal (roundToDay a) (roundToDay b)



-- TODO: These probably need extracting and testing on their own!


toTuplePair : List a -> Maybe ( a, a )
toTuplePair values =
    let
        first =
            List.head

        second =
            List.head << List.drop 1
    in
        case ( first values, second values ) of
            ( Just value1, Just value2 ) ->
                Just ( value1, value2 )

            default ->
                Nothing


toPairs : List a -> List ( a, a )
toPairs list =
    case toTuplePair list of
        Just pair ->
            pair :: (toPairs <| List.drop 1 list)

        Nothing ->
            []
