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
                    [ gameStatusText "Press space to start" white ]

                _ ->
                    let
                        pausedText =
                            case game.status of
                                Paused ->
                                    gameStatusText "Paused" white

                                _ ->
                                    gameStatusText (toString game.points) white

                        head =
                            square segmentSize
                                |> filled white
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
                                |> filled game.food.color
                                |> move (toFloatTuple game.food.position)
                    in
                        pausedText :: food :: head :: tail
    in
        collage gameBoardSize gameBoardSize (background :: content)
            |> Element.toHtml


gameStatusText : String -> Color -> Form
gameStatusText msg textColor =
    msg
        |> Text.fromString
        |> Text.color textColor
        |> Text.monospace
        |> Element.centered
        |> Collage.toForm
