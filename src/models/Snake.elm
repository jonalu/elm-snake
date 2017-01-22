module Snake exposing (..)

import Position exposing (..)
import Direction exposing (..)
import GameSettings exposing (segmentSize, initTailLength)


type alias Snake =
    { tail : List Position
    , head : Position
    , direction : Direction
    }


initTail : List Position
initTail =
    List.range 1 initTailLength
        |> List.map
            (\n ->
                Position.create (toFloat -n * segmentSize) (.y Position.init)
            )


init : Snake
init =
    { tail = initTail
    , head = Position.init
    , direction = Right
    }


updateDirection : Direction -> Snake -> Snake
updateDirection direction snake =
    { snake | direction = direction }


updatePosition : Snake -> Snake
updatePosition snake =
    { snake
        | head = Position.update snake.head snake.direction
        , tail = snake.head :: (List.take (List.length snake.tail - 1) snake.tail)
    }
