module Figure exposing (..)

import Position
import Svg exposing (Attribute, Svg)
import Svg.Attributes
import Svg.Node


circle : List (Attribute msg) -> Float -> ( Float, Float ) -> Svg msg
circle attrs radius ( x, y ) =
    Svg.Node.circle
        ([ Svg.Attributes.fill "transparent"
         , Svg.Attributes.stroke "black"
         ]
            ++ attrs
        )
        { x = x
        , y = y
        , r = radius
        }


bottomHalfCircle : List (Attribute msg) -> Float -> ( Float, Float ) -> Svg msg
bottomHalfCircle attrs radius ( x, y ) =
    Svg.Node.arc
        ([ Svg.Attributes.fill "transparent"
         , Svg.Attributes.stroke "black"
         ]
            ++ attrs
        )
        { x = x
        , y = y
        , radiusX = radius
        , radiusY = radius
        , fromAngle = pi
        , toAngle = 0
        }


topHalfCircle : List (Attribute msg) -> Float -> ( Float, Float ) -> Svg msg
topHalfCircle attrs radius ( x, y ) =
    Svg.Node.arc
        ([ Svg.Attributes.fill "transparent"
         , Svg.Attributes.stroke "black"
         ]
            ++ attrs
        )
        { x = x
        , y = y
        , radiusX = radius
        , radiusY = radius
        , fromAngle = 0
        , toAngle = pi
        }


rightHalfCircle : List (Attribute msg) -> Float -> ( Float, Float ) -> Svg msg
rightHalfCircle attrs radius ( x, y ) =
    Svg.Node.arc
        ([ Svg.Attributes.fill "transparent"
         , Svg.Attributes.stroke "black"
         ]
            ++ attrs
        )
        { x = x
        , y = y
        , radiusX = radius
        , radiusY = radius
        , fromAngle = pi / 2
        , toAngle = pi * 3 / 2
        }


leftHalfCircle : List (Attribute msg) -> Float -> ( Float, Float ) -> Svg msg
leftHalfCircle attrs radius ( x, y ) =
    Svg.Node.arc
        ([ Svg.Attributes.fill "transparent"
         , Svg.Attributes.stroke "black"
         ]
            ++ attrs
        )
        { x = x
        , y = y
        , radiusX = radius
        , radiusY = radius
        , fromAngle = pi * 3 / 2
        , toAngle = pi / 2
        }


triangleUp : List (Attribute msg) -> Float -> ( Float, Float ) -> Svg msg
triangleUp attrs size ( x, y ) =
    Svg.Node.polygon
        ([ Svg.Attributes.fill "transparent"
         , Svg.Attributes.stroke "black"
         ]
            ++ attrs
        )
        { points = 3
        , x = x
        , y = y
        , r = size
        , rotation = -pi / 2
        }


triangleDown : List (Attribute msg) -> Float -> ( Float, Float ) -> Svg msg
triangleDown attrs size ( x, y ) =
    Svg.Node.polygon
        ([ Svg.Attributes.fill "transparent"
         , Svg.Attributes.stroke "black"
         ]
            ++ attrs
        )
        { points = 3
        , x = x
        , y = y
        , r = size
        , rotation = pi / 2
        }


square : List (Attribute msg) -> Float -> ( Float, Float ) -> List (Svg msg)
square attrs radius pos =
    [ line attrs
        (Position.sum
            [ pos
            , Position.left radius
            , Position.top radius
            ]
        )
        (Position.sum
            [ pos
            , Position.left radius
            , Position.bottom radius
            ]
        )
    , line attrs
        (Position.sum
            [ pos
            , Position.right radius
            , Position.top radius
            ]
        )
        (Position.sum
            [ pos
            , Position.right radius
            , Position.bottom radius
            ]
        )
    , line attrs
        (Position.sum
            [ pos
            , Position.left radius
            , Position.top radius
            ]
        )
        (Position.sum
            [ pos
            , Position.right radius
            , Position.top radius
            ]
        )
    , line attrs
        (Position.sum
            [ pos
            , Position.left radius
            , Position.bottom radius
            ]
        )
        (Position.sum
            [ pos
            , Position.right radius
            , Position.bottom radius
            ]
        )
    ]


cross : List (Attribute msg) -> Float -> ( Float, Float ) -> List (Svg msg)
cross attrs radius pos =
    [ line attrs
        (Position.left radius |> Position.add pos)
        (Position.right radius |> Position.add pos)
    , line attrs
        (Position.top radius |> Position.add pos)
        (Position.bottom radius |> Position.add pos)
    ]


star : List (Attribute msg) -> Float -> ( Float, Float ) -> List (Svg msg)
star attrs radius pos =
    [ line attrs
        (Position.top radius |> Position.add pos)
        (Position.bottom radius |> Position.add pos)
    , line attrs
        (Position.topLeft radius |> Position.add pos)
        (Position.bottomRight radius |> Position.add pos)
    , line attrs
        (Position.bottomLeft radius |> Position.add pos)
        (Position.topRight radius |> Position.add pos)
    ]


line : List (Attribute msg) -> ( Float, Float ) -> ( Float, Float ) -> Svg msg
line attrs p1 p2 =
    Svg.Node.path
        ([ Svg.Attributes.fill "transparent"
         , Svg.Attributes.stroke "black"
         ]
            ++ attrs
        )
        [ p1, p2 ]
