module Singularis.View.Rule exposing (rule)

import Binary
import Random exposing (Generator)


words : List String
words =
    List.concat
        [ [ "Flower", "Stone", "Shrine", "Life", "Order", "Book" ]
        , [ "Joy", "Sadness", "Anger", "Danger", "Love", "Trust" ]
        , [ "Good", "Bad", "Black", "White", "Friend", "Foe" ]
        , [ "Door", "Key", "Hearth", "Time", "Lock", "Weapon" ]
        ]


ends : List String
ends =
    List.concat
        [ [ "None.", "One." ]
        , [ "Waiting.", "Lost." ]
        , [ "Open.", "Stay.", "See.", "Find.", "Believe." ]
        , [ "Luck.", "Future.", "Past." ]
        ]


rule : Generator (List String)
rule =
    let
        wordGenerator : Generator String
        wordGenerator =
            Random.uniform "God" words

        endGenerator : Generator String
        endGenerator =
            Random.uniform "Forever." ends
    in
    Random.map4
        (\s1 s2 s3 e ->
            List.concat
                [ [ s1 ++ " is " ++ s2 ++ ","
                  , s2 ++ " is " ++ s3 ++ ","
                  ]
                , e
                    |> String.toList
                    |> List.map
                        (Char.toCode
                            >> Binary.fromDecimal
                            >> Binary.ensureSize 8
                            >> Binary.toIntegers
                            >> List.map String.fromInt
                            >> String.concat
                        )
                ]
        )
        wordGenerator
        wordGenerator
        wordGenerator
        endGenerator