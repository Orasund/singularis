module MinuteDisplay exposing (..)

import Maths
import Svg exposing (Attribute, Svg)
import Svg.Attributes


viewCircle : List (Attribute msg) -> ( Float, Float ) -> Float -> Svg msg
viewCircle attrs ( x, y ) radius =
    Svg.circle
        ([ Svg.Attributes.cx (String.fromFloat x)
         , Svg.Attributes.cy (String.fromFloat y)
         , Svg.Attributes.fill "transparent"
         , Svg.Attributes.stroke "black"
         , Svg.Attributes.r (String.fromFloat radius)
         ]
            ++ attrs
        )
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


toSvg : { innerRadius : Float, outerRadius : Float, center : ( Float, Float ), rotation : Float } -> List (Svg msg)
toSvg args =
    List.range 0 0
        |> List.map
            (\i ->
                viewLine
                    (fromPolar ( args.outerRadius, pi * 2 * toFloat i / 12 + args.rotation )
                        |> Maths.plus args.center
                    )
                    (fromPolar ( args.innerRadius, pi * 2 * toFloat i / 12 + args.rotation )
                        |> Maths.plus args.center
                    )
            )
        {--|> (++)
        (List.range 60 60
        --1 12
        |> List.map
            (\i ->
                viewLabel
                    (fromPolar
                        ( args.innerRadius + ((args.outerRadius - args.innerRadius) / 2)
                        , pi * 2 * toFloat (i - 15) / 60 + args.rotation
                        )
                        |> Maths.plus args.center
                    )
                    (String.fromInt i)
            )
    )--}
        |> (++)
            [ viewCircle [ Svg.Attributes.fill "gray" ]
                args.center
                args.outerRadius
            , viewCircle
                [ Svg.Attributes.fill "white" ]
                args.center
                args.innerRadius
            ]
