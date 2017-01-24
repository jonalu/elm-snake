module Game exposing (..)

import GameStatus exposing (..)
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
    , snake = Snake.init
    , food = Food.init
    , points = 0
    }
