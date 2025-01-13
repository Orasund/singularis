module Alchemy exposing (..)

import Figure
import Position


salt attrs center =
    [ Figure.circle attrs
        Position.big
        center
    , Figure.line attrs
        ([ center
         , Position.left Position.big
         ]
            |> Position.sum
        )
        ([ center
         , Position.right Position.big
         ]
            |> Position.sum
        )
    ]


sulfur attrs center =
    [ Figure.triangleUp attrs Position.big center
    , Figure.line attrs
        (Position.bottom Position.normal
            |> Position.add center
        )
        (Position.bottom Position.big
            |> Position.times 2
            |> Position.add center
        )
    , Figure.line attrs
        (Position.bottom Position.normal
            |> Position.times 3
            |> Position.add (Position.left Position.normal)
            |> Position.add center
        )
        (Position.bottom Position.normal
            |> Position.times 3
            |> Position.add (Position.right Position.normal)
            |> Position.add center
        )
    ]
