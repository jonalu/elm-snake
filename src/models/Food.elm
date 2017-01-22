module Food exposing (..)

import Position exposing (..)


type alias Food =
    { position : Position
    }


init : Food
init =
    { position = Position.create 0.0 0.0
    }
