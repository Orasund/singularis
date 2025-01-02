module Singularis.Page.Codex exposing (view)

import Dict exposing (Dict)
import Element exposing (Element)
import Element.Font as Font
import Http exposing (Error(..))
import Random exposing (Generator)
import Singularis.View.Book as Book
import Singularis.View.Element as Element
import Singularis.View.Rule as Rule


codex : Float -> Generator (Element msg)
codex scale =
    Rule.rule
        |> Random.list 12
        |> Random.map
            (List.indexedMap
                (\i list ->
                    list
                        |> List.map (Element.text >> Element.el [ Element.centerX ])
                        |> (::) (String.fromInt (i + 1) ++ "." |> Element.subsection scale)
                        |> Element.column [ Element.height <| Element.px <| 250 ]
                )
                >> Element.wrappedRow [ Element.spacing 10, Element.centerX, Font.center ]
            )


view : Float -> Dict String (Element msg)
view scale =
    Dict.fromList <|
        [ ( "codex"
          , Random.step (codex scale) (Random.initialSeed 42)
                |> Tuple.first
          )
        ]