module Zodiac exposing (..)

import Figure
import Position


aries attrs center =
    [ [ center
      , Position.left Position.normal
      , Position.top Position.big
      ]
        |> Position.sum
        |> Figure.topHalfCircle attrs
            Position.normal
    , [ center
      , Position.right Position.normal
      , Position.top Position.big
      ]
        |> Position.sum
        |> Figure.topHalfCircle attrs
            Position.normal
    , Figure.line attrs
        ([ center
         , Position.top Position.big
         ]
            |> Position.sum
        )
        ([ center
         , Position.bottom Position.big
         ]
            |> Position.sum
        )
    ]


taurus attrs center =
    [ Figure.circle attrs
        Position.big
        center
    , Figure.bottomHalfCircle attrs
        Position.big
        (Position.top Position.giant
            |> Position.add center
        )
    ]


gemini attrs center =
    [ [ center
      , Position.top Position.normal
            |> Position.times 2
      ]
        |> Position.sum
        |> Figure.bottomHalfCircle attrs
            Position.big
    , [ center
      , Position.bottom Position.normal
            |> Position.times 2
      ]
        |> Position.sum
        |> Figure.topHalfCircle attrs
            Position.big
    ]


cancer attrs center =
    [ [ center
      , Position.topLeft Position.normal
      ]
        |> Position.sum
        |> Figure.circle attrs Position.normal
    , [ center
      , Position.bottomRight Position.normal
      ]
        |> Position.sum
        |> Figure.circle attrs Position.normal
    , [ center
      ]
        |> Position.sum
        |> Figure.topHalfCircle attrs
            Position.big
    , [ center
      ]
        |> Position.sum
        |> Figure.bottomHalfCircle attrs
            Position.big
    ]


leo attrs center =
    [ [ center
      , Position.top Position.normal
      ]
        |> Position.sum
        |> Figure.circle attrs
            Position.normal
    , [ center
      , Position.top Position.big
      , Position.right Position.normal
      ]
        |> Position.sum
        |> Figure.topHalfCircle attrs
            Position.normal
    , Figure.line attrs
        ([ center
         , Position.right Position.big
         , Position.top Position.big
         ]
            |> Position.sum
        )
        ([ center
         , Position.right Position.big
         , Position.bottom Position.big
         ]
            |> Position.sum
        )
    , [ center
      , Position.right Position.normal
            |> Position.times 3
      , Position.bottom Position.big
      ]
        |> Position.sum
        |> Figure.bottomHalfCircle attrs
            Position.normal
    ]


virgo attrs center =
    [ Figure.line attrs
        ([ center
         , Position.left Position.big
         , Position.top Position.big
         ]
            |> Position.sum
        )
        ([ center
         , Position.left Position.big
         , Position.bottom Position.big
         ]
            |> Position.sum
        )
    , Figure.line attrs
        ([ center
         , Position.top Position.big
         ]
            |> Position.sum
        )
        ([ center
         , Position.bottom Position.big
         ]
            |> Position.sum
        )
    , Figure.line attrs
        ([ center
         , Position.right Position.big
         , Position.top Position.big
         ]
            |> Position.sum
        )
        ([ center
         , Position.right Position.big
         , Position.bottom Position.normal
            |> Position.times 2
         ]
            |> Position.sum
        )
    , Figure.topHalfCircle attrs
        Position.normal
        ([ center
         , Position.right Position.normal
            |> Position.times 3
         ]
            |> Position.sum
        )
    , Figure.topHalfCircle attrs
        Position.normal
        ([ center
         , Position.top Position.big
         , Position.left Position.normal
         ]
            |> Position.sum
        )
    , Figure.topHalfCircle attrs
        Position.normal
        ([ center
         , Position.top Position.big
         , Position.right Position.normal
         ]
            |> Position.sum
        )
    , Figure.bottomHalfCircle attrs
        Position.big
        ([ center
         , Position.right Position.big
         ]
            |> Position.sum
        )
    ]


libra attrs center =
    [ Figure.circle attrs
        Position.big
        center
    , Figure.line attrs
        ([ center
         , Position.bottomLeft Position.big
            |> Position.times 2
         ]
            |> Position.sum
        )
        ([ center
         , Position.bottomRight Position.big
            |> Position.times 2
         ]
            |> Position.sum
        )
    , Figure.line attrs
        ([ center
         , Position.bottom Position.normal
         , Position.bottomLeft Position.big
            |> Position.times 2
         ]
            |> Position.sum
        )
        ([ center
         , Position.bottom Position.normal
         , Position.bottomRight Position.big
            |> Position.times 2
         ]
            |> Position.sum
        )
    ]


scorpio attrs center =
    [ Figure.line attrs
        ([ center
         , Position.left Position.big
         , Position.top Position.big
         ]
            |> Position.sum
        )
        ([ center
         , Position.left Position.big
         , Position.bottom Position.big
         ]
            |> Position.sum
        )
    , Figure.line attrs
        ([ center
         , Position.top Position.big
         ]
            |> Position.sum
        )
        ([ center
         , Position.bottom Position.big
         ]
            |> Position.sum
        )
    , Figure.line attrs
        ([ center
         , Position.right Position.big
         , Position.top Position.big
         ]
            |> Position.sum
        )
        ([ center
         , Position.right Position.big
         , Position.bottom Position.big
         ]
            |> Position.sum
        )
    , Figure.bottomHalfCircle attrs
        Position.normal
        ([ center
         , Position.bottom Position.big
         , Position.right Position.normal
            |> Position.times 3
         ]
            |> Position.sum
        )
    , Figure.topHalfCircle attrs
        Position.normal
        ([ center
         , Position.top Position.big
         , Position.left Position.normal
         ]
            |> Position.sum
        )
    , Figure.topHalfCircle attrs
        Position.normal
        ([ center
         , Position.top Position.big
         , Position.right Position.normal
         ]
            |> Position.sum
        )
    ]


sagittarius attrs center =
    [ Figure.line attrs
        ([ center
         , Position.bottomLeft Position.big
         ]
            |> Position.sum
        )
        ([ center
         , Position.topRight Position.big
         ]
            |> Position.sum
        )
    , Figure.line attrs
        ([ center
         , Position.topLeft Position.normal
         ]
            |> Position.sum
        )
        ([ center
         , Position.bottom Position.normal
         ]
            |> Position.sum
        )
    , Figure.line attrs
        ([ center
         , Position.topRight Position.big
         ]
            |> Position.sum
        )
        ([ center
         , Position.topRight Position.big
         , Position.bottom Position.normal
         ]
            |> Position.sum
        )
    , Figure.line attrs
        ([ center
         , Position.topRight Position.big
         ]
            |> Position.sum
        )
        ([ center
         , Position.topRight Position.big
         , Position.topLeft Position.normal
         ]
            |> Position.sum
        )
    ]


capricorn attrs center =
    [ Figure.line attrs
        ([ center
         , Position.top Position.big
         ]
            |> Position.sum
        )
        ([ center
         , Position.bottom Position.big
         ]
            |> Position.sum
        )
    , Figure.line attrs
        ([ center
         , Position.right Position.big
         , Position.top Position.big
         ]
            |> Position.sum
        )
        ([ center
         , Position.right Position.big
         , Position.bottom Position.big
         ]
            |> Position.sum
        )
    , Figure.bottomHalfCircle attrs
        Position.big
        ([ center
         , Position.bottom Position.big
         , Position.right Position.normal
            |> Position.times 0
         ]
            |> Position.sum
        )
    , Figure.topHalfCircle attrs
        Position.normal
        ([ center
         , Position.top Position.big
         , Position.left Position.normal
         ]
            |> Position.sum
        )
    , Figure.topHalfCircle attrs
        Position.normal
        ([ center
         , Position.top Position.big
         , Position.right Position.normal
         ]
            |> Position.sum
        )
    , Figure.circle attrs
        Position.normal
        ([ center
         , Position.bottom Position.big
         , Position.right Position.normal
            |> Position.times 3
         ]
            |> Position.sum
        )
    ]


aquarius attrs center =
    [ Figure.bottomHalfCircle attrs
        Position.normal
        ([ center
         , Position.top Position.normal
         , Position.left Position.big
         ]
            |> Position.sum
        )
    , Figure.bottomHalfCircle attrs
        Position.normal
        ([ center
         , Position.top Position.normal
         ]
            |> Position.sum
        )
    , Figure.bottomHalfCircle attrs
        Position.normal
        ([ center
         , Position.top Position.normal
         , Position.right Position.big
         ]
            |> Position.sum
        )
    , Figure.bottomHalfCircle attrs
        Position.normal
        ([ center
         , Position.bottom Position.normal
         , Position.left Position.big
         ]
            |> Position.sum
        )
    , Figure.bottomHalfCircle attrs
        Position.normal
        ([ center
         , Position.bottom Position.normal
         ]
            |> Position.sum
        )
    , Figure.bottomHalfCircle attrs
        Position.normal
        ([ center
         , Position.bottom Position.normal
         , Position.right Position.big
         ]
            |> Position.sum
        )
    ]


pisces attrs center =
    [ Figure.rightHalfCircle attrs
        Position.big
        ([ center
         , Position.left Position.big
         ]
            |> Position.sum
        )
    , Figure.leftHalfCircle attrs
        Position.big
        ([ center
         , Position.right Position.big
         ]
            |> Position.sum
        )
    , Figure.line attrs
        ([ center
         , Position.right Position.big
         ]
            |> Position.sum
        )
        ([ center
         , Position.left Position.big
         ]
            |> Position.sum
        )
    ]
