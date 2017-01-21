module Key exposing (..)


type Key
    = ArrowUp
    | ArrowRight
    | ArrowDown
    | ArrowLeft
    | Unknown


fromKeyCode : Int -> Key
fromKeyCode keyCode =
    case keyCode of
        37 ->
            ArrowLeft

        38 ->
            ArrowUp

        39 ->
            ArrowRight

        40 ->
            ArrowDown

        _ ->
            Unknown
