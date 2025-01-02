module Singularis.Page.Home exposing (view)

import Color
import Dict exposing (Dict)
import Element exposing (Element)
import Geometry.Svg as Svg
import Point2d exposing (Point2d)
import Polygon2d exposing (Polygon2d)
import Singularis.Page as Page exposing (Route(..))
import Singularis.View exposing (svgSize)
import Singularis.View.Element as Element
import Singularis.View.Polygon as Polygon
import TypedSvg as Svg
import TypedSvg.Attributes as Attributes
import TypedSvg.Core exposing (Svg)
import TypedSvg.Types as Types
import Vector2d exposing (Vector2d)


view : Float -> Dict String (Element msg)
view scale =
    Dict.fromList <|
        [ ( "elements"
          , Element.row
                [ Element.width <| Element.fill
                , Element.spaceEvenly
                , Element.centerX
                ]
            <|
                [ Element.column []
                    [ Element.html <| Polygon.view scale <| 3
                    , Element.el [ Element.centerX ] <| Element.text "Spirit"
                    ]
                , Element.column []
                    [ Element.html <| Polygon.view scale <| 4
                    , Element.el [ Element.centerX ] <| Element.text "Matter"
                    ]
                , Element.column []
                    [ Element.html <| Polygon.view scale <| 6
                    , Element.el [ Element.centerX ] <| Element.text "Knowledge"
                    ]
                ]
          )
        ]
