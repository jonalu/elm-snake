module Snake exposing (..)

import Position exposing (..)
import Direction exposing (..)


type alias Snake =
    { tail : List Position
    , position : Position
    , direction : Direction
    }


init : Snake
init =
    { tail = []
    , position = Position.create 0.0 0.0
    , direction = Right
    }


updateDirection : Direction -> Snake -> Snake
updateDirection direction snake =
    { snake | direction = direction }


updatePosition : Snake -> Snake
updatePosition snake =
    { snake | position = Position.update snake.position snake.direction }
