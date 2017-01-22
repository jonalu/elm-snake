module GameStatus exposing (..)


type GameStatus
    = Started
    | NotStarted


init : GameStatus
init =
    NotStarted


toggle : GameStatus -> GameStatus
toggle gameStatus =
    case gameStatus of
        Started ->
            NotStarted

        NotStarted ->
            Started
