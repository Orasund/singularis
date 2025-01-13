module Svg.Node exposing (..)

import Html exposing (Attribute)
import Position
import Svg exposing (Attribute, Svg)
import Svg.Attributes


circle :
    List (Attribute msg)
    -> { x : Float, y : Float, r : Float }
    -> Svg msg
circle attrs args =
    Svg.circle
        ([ Svg.Attributes.cx (String.fromFloat args.x)
         , Svg.Attributes.cy (String.fromFloat args.y)
         , Svg.Attributes.r (String.fromFloat args.r)
         ]
            ++ attrs
        )
        []


polygon :
    List (Attribute msg)
    ->
        { points : Int
        , x : Float
        , y : Float
        , r : Float
        , rotation : Float
        }
    -> Svg msg
polygon attrs args =
    List.range 0 (args.points - 1)
        |> List.map
            (\i ->
                fromPolar
                    ( args.r
                    , args.rotation + 2 * pi * toFloat i / toFloat args.points
                    )
                    |> Position.add ( args.x, args.y )
            )
        |> path attrs


path : List (Attribute msg) -> List ( Float, Float ) -> Svg msg
path attrs list =
    let
        d =
            "M"
                ++ (list
                        |> List.map (\( x, y ) -> String.fromFloat x ++ ", " ++ String.fromFloat y)
                        |> String.join " L"
                   )
                ++ "Z"
    in
    Svg.path (Svg.Attributes.d d :: attrs) []


arc :
    List (Attribute msg)
    ->
        { x : Float
        , y : Float
        , radiusX : Float
        , radiusY : Float
        , fromAngle : Float
        , toAngle : Float
        }
    -> Svg msg
arc attrs args =
    let
        ( x1, y1 ) =
            fromPolar ( 1, args.fromAngle )
                |> Tuple.mapBoth ((*) args.radiusX)
                    ((*) args.radiusY)
                |> Position.add ( args.x, args.y )

        ( x2, y2 ) =
            fromPolar ( 1, args.toAngle )
                |> Tuple.mapBoth ((*) args.radiusX)
                    ((*) args.radiusY)
                |> Position.add ( args.x, args.y )

        d =
            "M "
                ++ String.fromFloat x1
                ++ ","
                ++ String.fromFloat y1
                ++ "A "
                ++ String.fromFloat args.radiusX
                ++ " "
                ++ String.fromFloat args.radiusY
                ++ " 0 0 0 "
                ++ String.fromFloat x2
                ++ ","
                ++ String.fromFloat y2
    in
    Svg.path (Svg.Attributes.d d :: attrs) []


rect :
    List (Attribute msg)
    -> { x : Float, y : Float, width : Float, height : Float }
    -> Svg msg
rect attrs args =
    Svg.rect
        ([ Svg.Attributes.x (String.fromFloat args.x)
         , Svg.Attributes.y (String.fromFloat args.y)
         , Svg.Attributes.width (String.fromFloat args.width)
         , Svg.Attributes.height (String.fromFloat args.height)
         ]
            ++ attrs
        )
        []
