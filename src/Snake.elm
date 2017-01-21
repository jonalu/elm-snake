module Game exposing (..)

import Key exposing (..)
import Html exposing (Html, text, div)
import Keyboard exposing (KeyCode)
import Time exposing (Time)
import AnimationFrame


main : Program Never Game Msg
main =
    Html.program
        { init = init
        , view = view
        , update = updateGame
        , subscriptions = subscriptions
        }


updateGame : Msg -> Game -> ( Game, Cmd Msg )
updateGame msg gameBoard =
    case msg of
        KeyDown keyCode ->
            ( { gameBoard | snake = keyDown keyCode gameBoard.snake }, Cmd.none )

        Tick t ->
            ( applyTime gameBoard, Cmd.none )


gameBoardSize : Float
gameBoardSize =
    100.0


snakeWidth : Float
snakeWidth =
    2.5


view : Game -> Html msg
view gameBoard =
    Html.text <| toString gameBoard.snake


subscriptions : Game -> Sub Msg
subscriptions model =
    Sub.batch
        [ Keyboard.downs KeyDown
        , AnimationFrame.diffs Tick
        ]


initialSnake : Snake
initialSnake =
    { tail = []
    , position =
        { x = 0.0
        , y = 0.0
        }
    , direction = Right
    }


initialFood : Food
initialFood =
    { position =
        { x = 0.0
        , y = 0.0
        }
    }


initialGame : Game
initialGame =
    { snake = initialSnake
    , food = initialFood
    }


init : ( Game, Cmd Msg )
init =
    ( initialGame, Cmd.none )


type Msg
    = KeyDown KeyCode
    | Tick Time


type Direction
    = Up
    | Right
    | Down
    | Left


type alias Position =
    { x : Float
    , y : Float
    }


type alias Snake =
    { tail : List Position
    , position : Position
    , direction : Direction
    }


type alias Game =
    { snake : Snake
    , food : Food
    }


type alias Food =
    { position : Position
    }


updateSnakeDirection : Direction -> Snake -> Snake
updateSnakeDirection direction snake =
    { snake | direction = direction }


updateSnakePosition : Snake -> Snake
updateSnakePosition snake =
    { snake | position = getNewPosition snake.position snake.direction }


getNewPosition : Position -> Direction -> Position
getNewPosition position direction =
    case direction of
        Up ->
            { position | y = increase position.y }

        Right ->
            { position | x = increase position.x }

        Left ->
            { position | x = decrease position.x }

        Down ->
            { position | y = decrease position.y }


decrease : Float -> Float
decrease currentPos =
    if currentPos <= 0 then
        gameBoardSize - 1
    else
        currentPos - 1


increase : Float -> Float
increase currentPos =
    if currentPos >= gameBoardSize - 1 then
        0
    else
        currentPos + 1


applyTime : Game -> Game
applyTime gameBoard =
    { gameBoard | snake = updateSnakePosition gameBoard.snake }


keyDown : KeyCode -> Snake -> Snake
keyDown keyCode snake =
    case Key.fromKeyCode keyCode of
        ArrowUp ->
            updateSnakeDirection Up snake

        ArrowRight ->
            updateSnakeDirection Right snake

        ArrowDown ->
            updateSnakeDirection Down snake

        ArrowLeft ->
            updateSnakeDirection Left snake

        _ ->
            snake
