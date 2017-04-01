module Data.Duration exposing (Duration, fromTime, toTime)

import Time exposing (Time)


type Duration
    = Duration Time


fromTime : Time -> Duration
fromTime x =
    if x < 0 then
        Duration 0
    else if x > oneYear then
        Duration oneYear
    else
        Duration x


toTime : Duration -> Time
toTime (Duration x) =
    x


oneYear : Time
oneYear =
    31536000000
