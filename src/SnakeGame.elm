module SnakeGame exposing (..)

import Key exposing (..)
import Direction exposing (..)
import GameStatus exposing (..)
import Game exposing (..)
import Snake exposing (..)
import MainView exposing (..)
import Html exposing (Html, text, div)
import Keyboard exposing (KeyCode)
import Time exposing (Time)
import AnimationFrame


main : Program Never Game Msg
main =
    Html.program
        { init = init
        , view = MainView.view
        , update = updateGame
        , subscriptions = subscriptions
        }


init : ( Game, Cmd Msg )
init =
    ( Game.init
    , Cmd.none
    )


updateGame : Msg -> Game -> ( Game, Cmd Msg )
updateGame msg game =
    case game.status of
        Started ->
            case msg of
                KeyDown keyCode ->
                    ( handleKeyDown keyCode game
                    , Cmd.none
                    )

                Tick t ->
                    ( handleTick game
                    , Cmd.none
                    )

        NotStarted ->
            case msg of
                KeyDown keyCode ->
                    ( handleKeyDown keyCode game
                    , Cmd.none
                    )

                _ ->
                    ( game
                    , Cmd.none
                    )


subscriptions : Game -> Sub Msg
subscriptions game =
    case game.status of
        NotStarted ->
            Keyboard.downs KeyDown

        Started ->
            Sub.batch
                [ Keyboard.downs KeyDown
                , AnimationFrame.diffs Tick
                ]


type Msg
    = KeyDown KeyCode
    | Tick Time


handleTick : Game -> Game
handleTick game =
    { game
        | snake = Snake.updatePosition game.snake
    }


handleKeyDown : KeyCode -> Game -> Game
handleKeyDown keyCode game =
    case game.status of
        NotStarted ->
            { game
                | status = Started
            }

        Started ->
            case Key.fromKeyCode keyCode of
                ArrowUp ->
                    { game
                        | snake = Snake.updateDirection Up game.snake
                    }

                ArrowRight ->
                    { game
                        | snake = Snake.updateDirection Right game.snake
                    }

                ArrowDown ->
                    { game
                        | snake = Snake.updateDirection Down game.snake
                    }

                ArrowLeft ->
                    { game
                        | snake = Snake.updateDirection Left game.snake
                    }

                Space ->
                    { game
                        | status = NotStarted
                    }

                _ ->
                    game
