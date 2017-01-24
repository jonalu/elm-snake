module Food exposing (..)

import Position exposing (..)
import Random exposing (..)


type alias Food =
    { position : Position
    }


init : Food
init =
    { position = Position 0.0 70.0
    }


random : Random.Generator Food
random =
    map Food Position.random
