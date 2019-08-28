module Singularis.View.Book exposing (view)

import Element exposing (Element)
import Element.Border as Border
import String
import Char
import Binary

image : ((List Int,List Int),(List Int,List Int)) -> Element msg
image ((a,b),(c,d)) =
  Element.none

text : ((List Int,List Int),(List Int,List Int)) -> Element msg
text ((a,b),(c,d)) =
  [a,b,c,d]
    |> List.map
      ( List.map String.fromInt
        >> String.concat
        >> Element.text
      )
    |> Element.column
      [ Element.height <| Element.px <| 86
      , Element.spaceEvenly
      , Border.width <| 1
      , Element.padding <| 2
      ]

view : String -> Element msg
view =
  String.toUpper
    >> String.filter Char.isUpper
    >> String.toList
    >> List.map
      ( Char.toCode 
        >> Binary.fromDecimal
        >> Binary.ensureSize 8
      )
    >> Binary.concat
    >> Binary.chunksOf (8*4)
    >> List.filterMap
      ( Binary.chunksOf 8
        >> List.map Binary.toIntegers
        >> (\list ->
            case list of
              [a,b,c,d] ->
                Just ((a,b),(c,d))
              _ ->
                Nothing
          )
      )
    >> List.map text
    >> Element.wrappedRow
      [ Element.spacing <| 2
      , Element.centerX
      ]
