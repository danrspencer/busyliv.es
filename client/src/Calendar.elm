module Calendar exposing (generate)

import Date exposing (Date, Day(..))


--


generate : List Date -> List (List (Maybe Date))
generate =
    padWeeks >> splitToWeeks


padWeeks : List Date -> List (Maybe Date)
padWeeks dates =
    case
        ( List.head dates
        , List.head <| List.foldl (::) [] dates
        )
    of
        ( Just start, Just end ) ->
            List.concat
                [ padStart start
                , List.map Just dates
                , padEnd end
                ]

        default ->
            7 |> nothings


splitToWeeks : List (Maybe Date) -> List (List (Maybe Date))
splitToWeeks dates =
    case List.isEmpty dates of
        False ->
            (List.take 7 dates)
                :: splitToWeeks (List.drop 7 dates)

        True ->
            []


dayPosition : Date.Day -> Int
dayPosition day =
    case day of
        Sun ->
            0

        Mon ->
            1

        Tue ->
            2

        Wed ->
            3

        Thu ->
            4

        Fri ->
            5

        Sat ->
            6


padStart : Date -> List (Maybe a)
padStart =
    nothings << dayPosition << Date.dayOfWeek


padEnd : Date -> List (Maybe a)
padEnd =
    nothings << (-) 6 << dayPosition << Date.dayOfWeek


nothings : Int -> List (Maybe a)
nothings n =
    case n of
        0 ->
            []

        default ->
            Nothing :: nothings (n - 1)
