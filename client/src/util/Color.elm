module Util.Color exposing (RgbColor, rgbColorBlend, red, green, blue)

--


type alias RgbColor =
    ( Int, Int, Int )


red : RgbColor -> Int
red ( r, g, b ) =
    r


green : RgbColor -> Int
green ( r, g, b ) =
    g


blue : RgbColor -> Int
blue ( r, g, b ) =
    b


rgbColorBlend : Int -> RgbColor -> RgbColor -> Int -> RgbColor
rgbColorBlend steps start end index =
    if steps == 0 || index == 0 then
        start
    else if index == (steps + 1) then
        end
    else
        ( calcColorValue steps (red start) (red end) index
        , calcColorValue steps (green start) (green end) index
        , calcColorValue steps (blue start) (blue end) index
        )


calcColorValue : Int -> Int -> Int -> Int -> Int
calcColorValue steps a b index =
    let
        diff =
            b - a

        step =
            (toFloat diff) / (toFloat <| steps + 1)

        adjust =
            floor <| step * (toFloat index)
    in
        a + adjust
