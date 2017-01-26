module Game exposing (..)

import GameStatus exposing (..)
import GameSettings exposing (segmentSize)
import Snake exposing (..)
import Food exposing (..)


type alias Game =
    { status : GameStatus
    , snake : Snake
    , food : Food
    , points : Int
    }


init : Game
init =
    { status = GameStatus.init
    , snake = Snake.init segmentSize
    , food = Food.init
    , points = 0
    }
