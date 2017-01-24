module Position exposing (..)

import GameSettings exposing (gameBoardSize, segmentSize)
import Direction exposing (..)
import Random exposing (..)


type alias Position =
    { x : Float
    , y : Float
    }


init : Position
init =
    Position 0.0 0.0


createRandomGenerator : Random.Generator Position
createRandomGenerator =
    map (\n -> { x = n, y = n }) (float -375.0 375.0)


toFloatTuple : Position -> ( Float, Float )
toFloatTuple position =
    ( position.x, position.y )


random : Generator Position
random =
    map2 Position (float -300.0 300.0) (float -300.0 300.0)


collision : Position -> Position -> Bool
collision posA posB =
    abs (posA.x - posB.x) < segmentSize && abs (posA.y - posB.y) < segmentSize


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
