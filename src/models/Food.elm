module Food exposing (..)

import Position exposing (..)
import Random exposing (..)


type alias Food =
    { position : Position
    }


init : Food
init =
    { position = Position.create 0.0 70.0
    }


createRandomGenerator : Random.Generator Food
createRandomGenerator =
    map
        (\n ->
            { position =
                { x = n
                , y = n
                }
            }
        )
        (float -375.0 375.0)
