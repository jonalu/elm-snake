module Food exposing (..)

import Position exposing (..)
import Random exposing (..)
import Color exposing (..)


type alias Food =
    { position : Position
    , color : Color
    }


init : Food
init =
    { position = Position 0.0 70.0
    , color = orange
    }


random : Random.Generator Food
random =
    map2 Food Position.random randomColor


randomColor : Generator Color
randomColor =
    map3 rgb (int 100 255) (int 0 255) (int 0 255)
