module Arcana exposing (..)

import Figure
import Position


fool attrs center =
    [ Figure.circle attrs
        Position.big
        center
    , Figure.line attrs
        ([ center
         , Position.bottomLeft Position.giant
         ]
            |> Position.sum
        )
        ([ center
         , Position.topRight Position.giant
         ]
            |> Position.sum
        )
    ]


magician attrs center =
    [ Figure.triangleUp attrs
        Position.normal
        ([ center
         , Position.top Position.small
            |> Position.times 5
         ]
            |> Position.sum
        )
    , Figure.triangleDown attrs
        Position.normal
        ([ center
         , Position.bottom Position.small
            |> Position.times 5
         ]
            |> Position.sum
        )
    ]
        ++ Figure.cross attrs
            Position.big
            center


highPriestess attrs center =
    [ Figure.circle attrs
        Position.big
        center
    , Figure.rightHalfCircle attrs
        Position.normal
        ([ center
         , Position.left Position.normal
            |> Position.times 3
         ]
            |> Position.sum
        )
    , Figure.leftHalfCircle attrs
        Position.normal
        ([ center
         , Position.right Position.normal
            |> Position.times 3
         ]
            |> Position.sum
        )
    ]


empress attrs center =
    [ Figure.circle attrs
        Position.big
        center
    , Figure.line attrs
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
        ++ Figure.star attrs
            Position.normal
            ([ center
             , Position.bottom Position.normal
                |> Position.times 3
             ]
                |> Position.sum
            )
