module Snake exposing (..)

import Position exposing (..)
import Direction exposing (..)
import GameSettings exposing (segmentSize, initTailLength)
import Color exposing (..)


type alias Snake =
    { tail : List Position
    , head : Position
    , direction : Direction
    , color : Color
    }


initTail : List Position
initTail =
    List.range 1 initTailLength
        |> List.map
            (\n ->
                Position (toFloat -n * segmentSize) (.y Position.init)
            )


init : Snake
init =
    { tail = initTail
    , head = Position.init
    , direction = Right
    , color = lightGreen
    }


updateDirection : Direction -> Snake -> Snake
updateDirection direction snake =
    { snake | direction = direction }


updateHead : Snake -> Position
updateHead snake =
    Position.update snake.head snake.direction


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
