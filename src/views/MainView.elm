module MainView exposing (..)

import Game exposing (..)
import Position exposing (..)
import GameStatus exposing (..)
import Html exposing (Html, text)
import GameSettings exposing (gameBoardSize, segmentSize)
import Element exposing (..)
import Collage exposing (..)
import Color exposing (..)
import Text


view : Game -> Html msg
view game =
    let
        background =
            square (toFloat gameBoardSize) |> filled black

        content =
            case game.status of
                NotStarted ->
                    [ txt "Press any key to start" ]

                Started ->
                    let
                        head =
                            square segmentSize
                                |> filled green
                                |> move (toFloatTuple game.snake.head)

                        tail =
                            game.snake.tail
                                |> List.map
                                    (\position ->
                                        square segmentSize
                                            |> filled game.snake.color
                                            |> move (toFloatTuple position)
                                    )

                        food =
                            square segmentSize
                                |> filled orange
                                |> move (toFloatTuple game.food.position)
                    in
                        food :: head :: tail
    in
        collage gameBoardSize gameBoardSize (background :: content)
            |> Element.toHtml


txt : String -> Form
txt msg =
    msg
        |> Text.fromString
        |> Text.color lightGreen
        |> Text.monospace
        |> Element.centered
        |> Collage.toForm
