module SnakeGame exposing (..)

import Key exposing (..)
import Direction exposing (..)
import GameStatus exposing (..)
import Game exposing (..)
import Food exposing (..)
import Snake exposing (..)
import Position exposing (..)
import MainView exposing (..)
import Html exposing (Html, text, div)
import Keyboard exposing (KeyCode)
import Time exposing (Time)
import AnimationFrame
import Color exposing (..)
import Random exposing (..)


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
                    (handleTick game)

                NewFood food ->
                    ( handleNewFood game food
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
    | NewFood Food


handleNewFood : Game -> Food -> Game
handleNewFood game food =
    { game
        | food = food
    }


handleTick : Game -> ( Game, Cmd Msg )
handleTick game =
    let
        snake =
            game.snake

        food =
            game.food

        caughtFood =
            Position.collision snake.head food.position

        color =
            case caughtFood of
                True ->
                    red

                False ->
                    game.snake.color

        msg =
            case caughtFood of
                True ->
                    Random.generate NewFood Food.random

                False ->
                    Cmd.none

        newSnake =
            { snake
                | color = color
                , head = Snake.updateHead snake
                , tail = Snake.updateTail snake
            }
    in
        ( { game
            | snake = newSnake
          }
        , msg
        )


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
