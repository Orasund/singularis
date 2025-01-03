module ZodiacCircle exposing (..)

import Maths
import Svg exposing (Svg)
import Svg.Attributes


viewCircle : ( Float, Float ) -> Float -> Svg msg
viewCircle ( x, y ) radius =
    Svg.circle
        [ Svg.Attributes.cx (String.fromFloat x)
        , Svg.Attributes.cy (String.fromFloat y)
        , Svg.Attributes.fill "transparent"
        , Svg.Attributes.stroke "black"
        , Svg.Attributes.r (String.fromFloat radius)
        ]
        []


viewLine : ( Float, Float ) -> ( Float, Float ) -> Svg msg
viewLine ( x1, y1 ) ( x2, y2 ) =
    Svg.line
        [ Svg.Attributes.x1 (String.fromFloat x1)
        , Svg.Attributes.y1 (String.fromFloat y1)
        , Svg.Attributes.x2 (String.fromFloat x2)
        , Svg.Attributes.y2 (String.fromFloat y2)
        , Svg.Attributes.stroke "black"
        ]
        []


viewLabel ( x, y ) label =
    Svg.text_
        [ Svg.Attributes.x (String.fromFloat x)
        , Svg.Attributes.y (String.fromFloat y)
        , Svg.Attributes.textAnchor "middle"
        , Svg.Attributes.alignmentBaseline "central"
        ]
        [ Svg.text label ]


toSvg : { innerRadius : Float, outerRadius : Float, center : ( Float, Float ) } -> List (Svg msg)
toSvg args =
    List.range 0 11
        |> List.map
            (\i ->
                viewLine
                    (fromPolar ( args.outerRadius, pi * 2 * toFloat i / 12 )
                        |> Maths.plus args.center
                    )
                    (fromPolar ( args.innerRadius, pi * 2 * toFloat i / 12 )
                        |> Maths.plus args.center
                    )
            )
        |> (++)
            ([ "♈️"
             , "♉️"
             , "♊️"
             , "♋️"
             , "♌️"
             , "♍️"
             , "♎️"
             , "♏️"
             , "♐️"
             , "♑️"
             , "♒️"
             , "♓️"
             ]
                |> List.indexedMap
                    (\i label ->
                        viewLabel
                            (fromPolar
                                ( args.innerRadius + ((args.outerRadius - args.innerRadius) / 2)
                                , pi * 2 * (toFloat i + 0.5) / 12
                                )
                                |> Maths.plus args.center
                            )
                            label
                    )
            )
        |> (++)
            [ viewCircle args.center args.innerRadius
            , viewCircle args.center args.outerRadius
            ]
