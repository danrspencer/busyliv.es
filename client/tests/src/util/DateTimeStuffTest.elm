module Src.Util.DateTimeStuffTest exposing (all)

import Date exposing (Date)
import Expect exposing (Expectation, equal)
import Fuzz exposing (Fuzzer, float, floatRange, int, intRange)
import List
import Maybe exposing (andThen, withDefault)
import ElmTest.Extra exposing (..)


--

import Util.DateTimeStuff as DateTimeStuff exposing (oneDay, oneWeek)


all : Test
all =
    describe "Util.DateTimeStuff"
        [ duration
        , addTime
        , dateLessThan
        , dateList
        ]


duration : Test
duration =
    describe "duration"
        [ fuzz2
            float
            float
            "calculates the millisconds between two dates"
          <|
            \a b ->
                let
                    dateA =
                        Date.fromTime <| a

                    dateB =
                        Date.fromTime <| b + Date.toTime dateA

                    timeA =
                        Date.toTime <| dateA

                    timeB =
                        Date.toTime <| dateB

                    duration =
                        DateTimeStuff.duration dateA dateB
                in
                    duration |> equal (timeB - timeA)
        ]


addTime : Test
addTime =
    describe "addTime"
        [ fuzz2
            float
            float
            "adds a specific amount of time onto a date"
          <|
            \a b ->
                let
                    date =
                        Date.fromTime <| b

                    time =
                        toFloat <| floor a

                    newDate =
                        DateTimeStuff.addTime time date
                in
                    (Date.toTime newDate) |> equal (time + Date.toTime date)
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
                    DateTimeStuff.dateLessThan dateA dateB |> Expect.true "dateA is less than dateB"
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
                    DateTimeStuff.dateLessThan dateA dateB |> Expect.false "dateA is not less than dateB"
        , test "equal dates are not less than" <|
            \() ->
                let
                    dateA =
                        Date.fromTime 100000000

                    dateB =
                        Date.fromTime 100000000
                in
                    DateTimeStuff.dateLessThan dateA dateB |> Expect.false "dateA is not less than dateB"
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
                        DateTimeStuff.dateRange millennium end
                in
                    case List.head result of
                        Just firstResult ->
                            firstResult |> equal millennium

                        Nothing ->
                            Expect.fail "No dates in list"
        , test "each element should be one day after the previous" <|
            \() ->
                let
                    end =
                        DateTimeStuff.addTime oneWeek millennium

                    result =
                        DateTimeStuff.dateRange millennium end

                    expected =
                        [ millennium
                        , millennium |> DateTimeStuff.addTime (1 * oneDay)
                        , millennium |> DateTimeStuff.addTime (2 * oneDay)
                        , millennium |> DateTimeStuff.addTime (3 * oneDay)
                        , millennium |> DateTimeStuff.addTime (4 * oneDay)
                        , millennium |> DateTimeStuff.addTime (5 * oneDay)
                        , millennium |> DateTimeStuff.addTime (6 * oneDay)
                        , millennium |> DateTimeStuff.addTime (7 * oneDay)
                        ]
                in
                    result |> equal expected
        , fuzz2
            (float)
            (floatRange oneWeek <| oneWeek * 52)
            "each element should be one day after the previous"
          <|
            \start end ->
                let
                    startDate =
                        Date.fromTime <| start

                    endDate =
                        Date.fromTime <| end + Date.toTime startDate

                    increment =
                        DateTimeStuff.addDay

                    result =
                        DateTimeStuff.dateRange startDate endDate

                    doDaysIncrement daysPair =
                        (roundToDay <| increment <| Tuple.first daysPair)
                            == (roundToDay <| Tuple.second daysPair)

                    daysIncremented =
                        List.foldl
                            (\pair result ->
                                result && doDaysIncrement pair
                            )
                            True
                        <|
                            toPairs result
                in
                    daysIncremented
                        |> Expect.true
                            ([ "Failed with ", toString startDate, " - ", toString endDate ] |> String.concat)
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
    equal (roundToDay a) (roundToDay b)



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
