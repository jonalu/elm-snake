module Snake exposing (..)

import Position exposing (..)
import Direction exposing (..)
import Color exposing (..)


type alias Snake =
    { tail : List Position
    , head : Position
    , direction : Direction
    , color : Color
    }


initTail : Float -> List Position
initTail segmentSize =
    List.range 1 4
        |> List.map
            (\n ->
                Position (toFloat -n * segmentSize) (.y Position.init)
            )


init : Float -> Snake
init segmentSize =
    { tail = initTail segmentSize
    , head = Position.init
    , direction = Right
    , color = lightGreen
    }


collision : Float -> Snake -> Bool
collision segmentSize snake =
    List.any (Position.overlap segmentSize snake.head) snake.tail


updateDirection : Direction -> Snake -> Snake
updateDirection direction snake =
    { snake | direction = direction }


updateHead : Float -> Float -> Snake -> Position
updateHead gameBoardSize segmentSize snake =
    Position.update gameBoardSize segmentSize snake.head snake.direction


updateTail : Snake -> Bool -> List Position
updateTail snake caughtFood =
    let
        tail =
            case caughtFood of
                True ->
                    snake.head :: snake.head :: (List.take (List.length snake.tail - 1) snake.tail)

                False ->
                    snake.head :: (List.take (List.length snake.tail - 1) snake.tail)
    in
        tail
