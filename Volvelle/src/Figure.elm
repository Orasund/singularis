module Figure exposing (..)

import Position
import Svg exposing (Attribute, Svg)
import Svg.Attributes
import Svg.Node
import Svg.Path


path : List (Attribute msg) -> String -> Svg msg
path attrs d =
    Svg.path (Svg.Attributes.d d :: attrs) []


circlePath { clockwise } radius center builder =
    builder
        |> Svg.Path.jumpTo (Position.add center ( 0, radius ))
        |> Svg.Path.drawArcTo (Position.add center ( 0, -radius ))
            { radiusX = radius
            , radiusY = radius
            , rotation = 0
            , takeTheLongWay = False
            , clockwise = clockwise
            }
        |> Svg.Path.drawArcTo (Position.add center ( 0, radius ))
            { radiusX = radius
            , radiusY = radius
            , rotation = 0
            , takeTheLongWay = False
            , clockwise = clockwise
            }


halfCircle { clockwise } radius center builder =
    builder
        |> Svg.Path.jumpTo (Position.add center ( 0, radius ))
        |> Svg.Path.drawArcTo (Position.add center ( 0, -radius ))
            { radiusX = radius
            , radiusY = radius
            , rotation = 0
            , takeTheLongWay = False
            , clockwise = clockwise
            }
        |> Svg.Path.drawLineTo (Position.add center ( 0, radius ))


line attrs p1 p2 =
    Svg.Node.path attrs
        [ p1
        , p2
        ]
