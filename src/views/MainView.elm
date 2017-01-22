module MainView exposing (..)

import Game exposing (..)
import Html exposing (Html, text)


view : Game -> Html msg
view game =
    Html.text <| toString game.snake
