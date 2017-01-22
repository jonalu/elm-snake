module Position exposing (..)

import GameSettings exposing (gameBoardSize)
import Direction exposing (..)


type alias Position =
    { x : Float
    , y : Float
    }


create : Float -> Float -> Position
create x y =
    { x = x, y = y }


update : Position -> Direction -> Position
update position direction =
    case direction of
        Up ->
            { position | y = increase position.y }

        Right ->
            { position | x = increase position.x }

        Left ->
            { position | x = decrease position.x }

        Down ->
            { position | y = decrease position.y }


decrease : Float -> Float
decrease currentPos =
    if currentPos <= 0 then
        gameBoardSize - 1
    else
        currentPos - 1


increase : Float -> Float
increase currentPos =
    if currentPos >= gameBoardSize - 1 then
        0
    else
        currentPos + 1
