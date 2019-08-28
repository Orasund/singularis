module Singularis.View.Word exposing (view)

import Binary
import Color
import Element exposing (Element)
import Geometry.Svg as Svg
import Point2d
import Polygon2d exposing (Polygon2d)
import Rectangle2d
import Singularis.View exposing (svgSize)
import TypedSvg as Svg
import TypedSvg.Attributes as Attributes
import TypedSvg.Types as Types
import Vector2d exposing (Vector2d)


square : { scale : Float, size : Float } -> ( Float, Float ) -> Polygon2d
square { scale, size } pos =
    let
        v =
            Vector2d.fromComponents pos
                |> Vector2d.scaleBy scale

        one =
            Point2d.fromCoordinates ( size * scale, size * scale )
    in
    Rectangle2d.from Point2d.origin one
        |> Rectangle2d.translateBy v
        |> Rectangle2d.toPolygon


numberToSquares : Int -> Float -> ( Float, Float ) -> List Polygon2d
numberToSquares num scale ( x, y ) =
    let
        ( ( ( _, _ ), ( _, b5 ) ), ( ( b4, b3 ), ( b2, b1 ) ) ) =
            num
                |> Binary.fromDecimal
                |> Binary.ensureSize 8
                |> Binary.toIntegers
                |> (\list ->
                        case list of
                            [ a, b, c, d, e, f, g, h ] ->
                                ( ( ( a == 1, b == 1 ), ( c == 1, d == 1 ) )
                                , ( ( e == 1, f == 1 ), ( g == 1, h == 1 ) )
                                )

                            _ ->
                                ( ( ( False, False ), ( False, False ) ), ( ( False, False ), ( False, False ) ) )
                   )
    in
    List.concat
        [ if b1 then
            square { scale = scale, size = 1 / 4 } ( x + 1 / 16, y + 1 / 16 )
                |> List.singleton

          else
            []
        , if b2 then
            square { scale = scale, size = 1 / 4 } ( x + 3 / 16, y + 3 / 16 )
                |> List.singleton

          else
            []
        , if b3 then
            square { scale = scale, size = 1 / 8 } ( x + 1 / 16, y + 1 / 16 )
                |> List.singleton

          else
            []
        , if b4 then
            square { scale = scale, size = 1 / 16 } ( x + 15 / 16, y + 15 / 16 )
                |> List.singleton

          else
            []
        , if b5 then
            square { scale = scale, size = 1 / 16 } ( x + 1 / 16, y + 1 / 16 )
                |> List.singleton

          else
            []
        ]


view : Float -> ( ( Int, Int ), ( Int, Int ) ) -> Element msg
view scale ( ( a, b ), ( c, d ) ) =
    Element.html <|
        Svg.svg
            [ Attributes.width <| Types.px <| scale
            , Attributes.height <| Types.px <| scale
            ]
        <|
            ([ [ square { scale = scale, size = 1 } ( 0, 0 )
               , square { scale = scale, size = 3 / 4 } ( 1 / 8, 1 / 8 )
               , square { scale = scale, size = 1 / 2 } ( 1 / 4, 1 / 4 )
               ]
             , numberToSquares a scale ( 0, 0 )
             , numberToSquares b scale ( 1 / 2, 0 )
             , numberToSquares c scale ( 0, 1 / 2 )
             , numberToSquares d scale ( 1 / 2, 1 / 2 )
             ]
                |> List.concat
                |> List.map
                    (Svg.polygon2d
                        [ Attributes.stroke Color.black
                        , Attributes.noFill
                        ]
                    )
            )