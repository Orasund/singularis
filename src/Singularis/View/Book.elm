module Singularis.View.Book exposing (view)

import Binary
import Char
import Element exposing (Element)
import Element.Border as Border
import List.Extra as List
import Singularis.View.Word as Word
import String


image : Float -> ( ( Int, Int ), ( Int, Int ) ) -> Element msg
image size =
    Element.el
        [ Element.height <| Element.px <| 86
        , Element.width <| Element.px <| 86
        , Element.alignLeft
        , Element.alignTop
        ]
        << Word.view size


text : ( ( Int, Int ), ( Int, Int ) ) -> Element msg
text ( ( a, b ), ( c, d ) ) =
    [ a, b, c, d ]
        |> List.map
            (Binary.fromDecimal
                >> Binary.ensureSize 8
                >> Binary.toIntegers
                >> List.map String.fromInt
                >> String.concat
                >> Element.text
            )
        |> Element.column
            [ Element.height <| Element.px <| 86
            , Element.spaceEvenly
            , Border.width <| 1
            , Element.padding <| 2
            , Element.alignLeft
            , Element.alignTop
            ]


view : String -> Element msg
view =
    String.toUpper
        >> String.filter Char.isUpper
        >> String.toList
        >> List.map Char.toCode
        >> List.groupsOf 4
        >> List.filterMap
            (\list ->
                case list of
                    [ a, b, c, d ] ->
                        Just ( ( a, b ), ( c, d ) )

                    _ ->
                        Nothing
            )
        >> List.indexedMap
            (\i ->
                if i |> modBy 42 |> (==) 0 then
                    text

                else
                    image 86
            )
        >> Element.paragraph
            [ Element.spacing <| 0
            , Element.centerX
            ]