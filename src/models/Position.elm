module Position exposing (..)

import GameSettings exposing (gameBoardSize, segmentSize)
import Direction exposing (..)


type alias Position =
    { x : Float
    , y : Float
    }


init : Position
init =
    create 0.0 0.0


create : Float -> Float -> Position
create x y =
    { x = x, y = y }


toFloatTuple : Position -> ( Float, Float )
toFloatTuple position =
    ( position.x, position.y )


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
    if currentPos <= toFloat -gameBoardSize / 2 then
        toFloat gameBoardSize / 2
    else
        currentPos - segmentSize


increase : Float -> Float
increase currentPos =
    if currentPos >= toFloat gameBoardSize / 2 then
        toFloat -gameBoardSize / 2
    else
        currentPos + segmentSize
