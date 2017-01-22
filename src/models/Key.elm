module Key exposing (..)


type Key
    = ArrowUp
    | ArrowRight
    | ArrowDown
    | ArrowLeft
    | Space
    | Unknown


fromKeyCode : Int -> Key
fromKeyCode keyCode =
    case keyCode of
        32 ->
            Space

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
