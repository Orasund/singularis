module OuterDial exposing (..)

import Figure
import Position
import Svg exposing (Svg)
import Svg.Attributes
import Svg.Node


toSvg : { radius : Float, innerRadius : Float } -> ( Float, Float ) -> List (Svg msg)
toSvg args ( x, y ) =
    [ [ Svg.Node.circle
            [ Svg.Attributes.fill "white"
            , Svg.Attributes.stroke "black"
            ]
            { x = x
            , y = y
            , radius = args.radius
            }
      , Svg.Node.circle
            [ Svg.Attributes.fill "white"
            , Svg.Attributes.stroke "black"
            ]
            { x = x
            , y = y
            , radius = args.innerRadius
            }
      ]
    , [ ( "January", 31 )
      , ( "February", 28 )
      , ( "March", 31 )
      , ( "April", 30 )
      , ( "May", 31 )
      , ( "June", 30 )
      , ( "July", 31 )
      , ( "August", 31 )
      , ( "September", 30 )
      , ( "October", 31 )
      , ( "November", 30 )
      , ( "December", 31 )
      ]
        |> List.indexedMap Tuple.pair
        |> List.foldl
            (\( i, ( name, daysOfMonth ) ) ( l, sum ) ->
                let
                    r =
                        (pi / 2) + (2 * pi * toFloat sum / 365)

                    ( x2, y2 ) =
                        fromPolar
                            ( args.radius - (args.radius - args.innerRadius) / 2
                            , pi / 2 + 2 * pi * (2 * toFloat i + 1) / 24
                            )
                            |> Position.add ( x, y )
                in
                ( [ ( x2, y2 )
                        |> Svg.Node.text
                            [ Svg.Attributes.transform
                                ("rotate("
                                    ++ String.fromFloat (30 * toFloat i + 195)
                                    ++ ","
                                    ++ String.fromFloat x2
                                    ++ ","
                                    ++ String.fromFloat y2
                                    ++ ")"
                                )
                            ]
                            { fontSize = 10
                            }
                            name
                  , Figure.line [ Svg.Attributes.stroke "black" ]
                        (fromPolar
                            ( args.radius, r )
                            |> Position.add ( x, y )
                        )
                        (fromPolar ( args.innerRadius, r )
                            |> Position.add ( x, y )
                        )
                  ]
                    ++ (List.range 1 5
                            |> List.map
                                (\j ->
                                    Figure.line [ Svg.Attributes.stroke "black" ]
                                        (fromPolar
                                            ( args.radius, r + (2 * pi * (toFloat j * 5) / 365) )
                                            |> Position.add ( x, y )
                                        )
                                        (fromPolar ( args.radius - (args.radius - args.innerRadius) / 4, r + (2 * pi * (toFloat j * 5) / 365) )
                                            |> Position.add ( x, y )
                                        )
                                )
                       )
                    ++ l
                , daysOfMonth + sum
                )
            )
            ( [], 0 )
        |> Tuple.first
    , List.range 0 364
        |> List.map
            (\i ->
                let
                    r =
                        pi / 2 + 2 * pi * toFloat i / 365
                in
                Svg.Node.path [ Svg.Attributes.stroke "black" ]
                    [ fromPolar
                        ( args.radius, r )
                        |> Position.add ( x, y )
                    , fromPolar ( args.radius - (args.radius - args.innerRadius) / 6, r )
                        |> Position.add ( x, y )
                    ]
            )
    ]
        |> List.concat
