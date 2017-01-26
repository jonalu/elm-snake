module PositionTest exposing (..)

import Test exposing (..)
import Position exposing (Position, overlap)
import Expect


all : Test
all =
    describe "Test models/Position.elm"
        [ overlapTest ]


overlapTest : Test
overlapTest =
    describe "Position.overlap"
        [ test "overlap if positions are equal" <|
            \() ->
                Expect.true "Expected overlap" <|
                    overlap 10
                        (Position 0.0 0.0)
                        (Position 0.0 0.0)
        , test "overlap when dy < segment size" <|
            \() ->
                Expect.true "Expected no overlap" <|
                    overlap 10
                        (Position 0.0 0.0)
                        (Position 0.0 9.0)
        , test "overlap when dx < segment size" <|
            \() ->
                Expect.true "Expected no overlap" <|
                    overlap 10
                        (Position 0.0 0.0)
                        (Position 9.0 0.0)
        , test "no overlap when dy >= segment size" <|
            \() ->
                Expect.false "Expected no overlap" <|
                    overlap 10
                        (Position 0.0 0.0)
                        (Position 0.0 10.0)
        , test "no overlap when dx >= segment size" <|
            \() ->
                Expect.false "Expected no overlap" <|
                    overlap 10
                        (Position 0.0 0.0)
                        (Position 10.0 0.0)
        ]
