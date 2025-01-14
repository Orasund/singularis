module SunDial exposing (..)

import Figure
import Position
import Svg exposing (Svg)
import Svg.Attributes
import Svg.Node
import Svg.Path


toSvg : { radius : Float, innerRadius : Float, moonRadius : Float, pointerRadius : Float } -> ( Float, Float ) -> List (Svg msg)
toSvg args ( x, y ) =
    [ [ Svg.Node.circle
            [ Svg.Attributes.fill "white"
            , Svg.Attributes.stroke "black"
            ]
            { x = x
            , y = y
            , radius = args.radius
            }
      , Svg.Path.startAt ( x, args.innerRadius )
            |> Figure.halfCircle { clockwise = True }
                args.innerRadius
                ( x, y )
            |> Svg.Path.end
            |> Svg.Path.toString
            |> Figure.path
                [ Svg.Attributes.fill "black"
                , Svg.Attributes.stroke "black"
                ]
      , Svg.Node.circle
            [ Svg.Attributes.fill "white"
            ]
            { x = x
            , y = y - args.moonRadius
            , radius = args.moonRadius
            }
      , Svg.Node.circle
            [ Svg.Attributes.fill "black"
            ]
            { x = x
            , y = y + args.moonRadius
            , radius = args.moonRadius
            }
      , Svg.Node.path [ Svg.Attributes.stroke "orange" ]
            [ fromPolar
                ( args.pointerRadius, pi / 2 )
                |> Position.add ( x, y )
            , fromPolar ( args.innerRadius, pi / 2 )
                |> Position.add ( x, y )
            ]
      ]
    , List.range 0 29
        |> List.map
            (\i ->
                let
                    r =
                        pi / 2 + 2 * pi * 2 * toFloat i / 59
                in
                Svg.Node.path [ Svg.Attributes.stroke "black" ]
                    [ fromPolar
                        ( args.radius - ((args.radius - args.innerRadius) * 2 / 4), r )
                        |> Position.add ( x, y )
                    , fromPolar ( args.innerRadius, r )
                        |> Position.add ( x, y )
                    ]
            )
    , List.range 0 28
        |> List.map
            (\i ->
                let
                    r =
                        pi / 2 + 2 * pi * (2 * toFloat i + 1) / 59

                    ( x2, y2 ) =
                        fromPolar ( args.radius - (args.radius - args.innerRadius) / 2, r )
                            |> Position.add ( x, y )
                in
                ( x2, y2 )
                    |> Svg.Node.text
                        [ Svg.Attributes.transform
                            ("rotate("
                                ++ String.fromFloat (360 * toFloat i / 29)
                                ++ ","
                                ++ String.fromFloat x2
                                ++ ","
                                ++ String.fromFloat y2
                                ++ ")"
                            )
                        ]
                        { fontSize = 12
                        }
                        (String.fromInt (i + 1))
            )
    ]
        |> List.concat
