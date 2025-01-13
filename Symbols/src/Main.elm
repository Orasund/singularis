module Main exposing (..)

import Alchemy
import Arcana
import Element
import Figure
import Html exposing (Html)
import Html.Attributes
import Planets
import Position
import Svg exposing (Svg)
import Svg.Attributes
import Zodiac


frameSize : Float
frameSize =
    Position.normal * 9


center : ( Float, Float )
center =
    ( frameSize / 2, frameSize / 2 )


frame : List (Svg.Svg msg) -> Html msg
frame =
    Svg.svg
        [ Svg.Attributes.height (String.fromFloat frameSize)
        , Svg.Attributes.width (String.fromFloat frameSize)
        ]


collection : String -> List (List (Svg.Svg msg)) -> Svg msg
collection title list =
    [ Html.h3 [] [ Html.text title ]
    , list
        |> List.map frame
        |> Html.div
            [ Html.Attributes.style "display" "flex"
            , Html.Attributes.style "flex-wrap" "wrap"
            ]
    ]
        |> Html.div
            [ Html.Attributes.style "display" "flex"
            , Html.Attributes.style "flex-direction" "column"
            ]


main : Html msg
main =
    [ [ [ [ center
          , Position.left Position.normal
          , Position.bottom Position.big
          ]
            |> Position.sum
            |> Figure.circle [] Position.normal
        , [ center
          , Position.right Position.normal
          , Position.bottom Position.big
          ]
            |> Position.sum
            |> Figure.circle [] Position.normal
        , Figure.line []
            ([ center
             , Position.topLeft Position.big
             ]
                |> Position.sum
            )
            ([ center
             , Position.topRight Position.big
             ]
                |> Position.sum
            )
        ]
            ++ Figure.cross []
                Position.big
                center
      , [ Figure.circle [] Position.big center
        , Figure.triangleUp [] Position.big center
        , Figure.circle [] Position.tiny center
        ]
            ++ Figure.square [] Position.small center
      , [ Figure.triangleUp [] Position.big center
        , Figure.bottomHalfCircle []
            Position.big
            center
        , Figure.line []
            ([ center
             , Position.bottom Position.big
             ]
                |> Position.sum
            )
            ([ center
             , Position.bottom Position.giant
             ]
                |> Position.sum
            )
        ]
      , [ Figure.circle []
            Position.normal
            ([ center
             , Position.top Position.normal
             ]
                |> Position.sum
            )
        , Figure.circle []
            Position.normal
            ([ center
             , Position.bottom Position.normal
             ]
                |> Position.sum
            )
        , Figure.bottomHalfCircle []
            Position.big
            ([ center
             , Position.top Position.giant
             ]
                |> Position.sum
            )
        , Figure.line []
            ([ center
             , Position.bottom Position.big
             ]
                |> Position.sum
            )
            ([ center
             , Position.top Position.giant
             ]
                |> Position.sum
            )
        ]
      ]
        |> collection ""
    , [ Alchemy.salt [] center
      , Alchemy.sulfur [] center
      ]
        |> collection "Alchemy"
    , [ Element.air [] center
      , Element.earth [] center
      , Element.fire [] center
      , Element.water [] center
      , Element.ather [] center
      ]
        |> collection "Element"
    , [ Arcana.fool [] center
      , Arcana.magician [] center
      , Arcana.highPriestess [] center
      , Arcana.empress [] center
      ]
        |> collection "Arcana"
    , [ Zodiac.aries [] center
      , Zodiac.taurus [] center
      , Zodiac.gemini [] center
      , Zodiac.cancer [] center
      , Zodiac.leo [] center
      , Zodiac.virgo [] center
      , Zodiac.libra [] center
      , Zodiac.scorpio [] center
      , Zodiac.sagittarius [] center
      , Zodiac.capricorn [] center
      , Zodiac.aquarius [] center
      , Zodiac.pisces [] center
      ]
        |> collection "Zodiacs"
    , [ Planets.pluto [] center
      , Planets.earth [] center
      , Planets.jupiter [] center
      , Planets.neptune [] center
      , Planets.saturn [] center
      , Planets.mars [] center
      , Planets.uranus [] center
      , Planets.sun [] center
      , Planets.mercury [] center
      , Planets.venus [] center
      , Planets.moon [] center
      ]
        |> collection "Planets"
    ]
        |> Html.div
            [ Html.Attributes.style "display" "flex"
            , Html.Attributes.style "flex-direction" "column"
            ]
