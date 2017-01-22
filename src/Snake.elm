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
updateGame msg game =
    case game.status of
        Started ->
            case msg of
                KeyDown keyCode ->
                    ( { game | snake = keyDown keyCode game.snake }, Cmd.none )

                Tick t ->
                    ( applyTime game, Cmd.none )

        NotStarted ->
            case msg of
                KeyDown keyCode ->
                    ( { game | status = Started, snake = keyDown keyCode game.snake }, Cmd.none )

                _ ->
                    ( game, Cmd.none )


gameBoardSize : Float
gameBoardSize =
    100.0


snakeWidth : Float
snakeWidth =
    2.5


view : Game -> Html msg
view game =
    Html.text <| toString game.snake


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


position : Float -> Float -> Position
position x y =
    { x = x, y = y }


initialSnake : Snake
initialSnake =
    { tail = []
    , position = position 0.0 0.0
    , direction = Right
    }


initialFood : Food
initialFood =
    { position = position 0.0 0.0
    }


initialGame : Game
initialGame =
    { status = NotStarted
    , snake = initialSnake
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


type GameStatus
    = Started
    | NotStarted


type alias Game =
    { status : GameStatus
    , snake : Snake
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
applyTime game =
    { game | snake = updateSnakePosition game.snake }


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
