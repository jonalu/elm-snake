module GameStatus exposing (..)


type GameStatus
    = Started
    | NotStarted
    | Paused


init : GameStatus
init =
    NotStarted
