module Position exposing (..)

import Direction exposing (..)
import Random exposing (..)


type alias Position =
    { x : Float
    , y : Float
    }


init : Position
init =
    Position 0.0 0.0


toFloatTuple : Position -> ( Float, Float )
toFloatTuple position =
    ( position.x, position.y )


random : Int -> Generator Position
random gameBoardSize =
    let
        minMax =
            toFloat gameBoardSize / 2
    in
        map2 Position (float -minMax minMax) (float -minMax minMax)


overlap : Float -> Position -> Position -> Bool
overlap segmentSize posA posB =
    abs (posA.x - posB.x) < segmentSize && abs (posA.y - posB.y) < segmentSize


update : Float -> Float -> Position -> Direction -> Position
update gameBoardSize segmentSize position direction =
    case direction of
        Up ->
            { position | y = increase gameBoardSize segmentSize position.y }

        Right ->
            { position | x = increase gameBoardSize segmentSize position.x }

        Left ->
            { position | x = decrease gameBoardSize segmentSize position.x }

        Down ->
            { position | y = decrease gameBoardSize segmentSize position.y }


decrease : Float -> Float -> Float -> Float
decrease gameBoardSize segmentSize currentPos =
    if currentPos <= -gameBoardSize / 2 then
        gameBoardSize / 2
    else
        currentPos - segmentSize


increase : Float -> Float -> Float -> Float
increase gameBoardSize segmentSize currentPos =
    if currentPos >= gameBoardSize / 2 then
        -gameBoardSize / 2
    else
        currentPos + segmentSize
