module MoonDial exposing (..)

import Figure
import Position
import Svg exposing (Svg)
import Svg.Attributes
import Svg.Node
import Svg.Path


toSvg : { radius : Float, moonRadius : Float, pointerRadius : Float } -> ( Float, Float ) -> List (Svg msg)
toSvg args center =
    let
        ( x, y ) =
            center
    in
    [ Svg.Path.startAt (Position.add center ( 0, args.radius ))
        |> Figure.circlePath { clockwise = False } args.radius center
        |> Figure.circlePath { clockwise = True } args.moonRadius (Position.add center ( -args.moonRadius, 0 ))
        |> Svg.Path.end
        |> Svg.Path.toString
        |> Figure.path
            [ Svg.Attributes.fill "white"
            , Svg.Attributes.stroke "black"
            , Svg.Attributes.x (String.fromFloat x)
            , Svg.Attributes.y (String.fromFloat y)
            ]
    , Svg.Node.path [ Svg.Attributes.stroke "gray" ]
        [ fromPolar ( args.pointerRadius, 0 ) |> Position.add center
        , fromPolar ( args.radius - args.radius / 4, 0 ) |> Position.add center
        ]
    , Svg.Node.path [ Svg.Attributes.stroke "black" ]
        [ fromPolar ( args.radius, 0 ) |> Position.add center
        , fromPolar ( args.radius - args.radius / 4, 0 ) |> Position.add center
        ]
    ]
