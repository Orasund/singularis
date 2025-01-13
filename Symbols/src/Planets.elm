module Planets exposing (..)

import Figure
import Position


pluto attrs center =
    [ Figure.bottomHalfCircle attrs
        Position.big
        center
    , Figure.circle attrs
        Position.normal
        center
    ]
        ++ Figure.cross attrs
            Position.normal
            (Position.bottom Position.normal
                |> Position.times 3
                |> Position.add center
            )


mercury attrs center =
    [ Figure.circle attrs Position.big center
    , Figure.bottomHalfCircle attrs
        Position.normal
        (Position.top Position.normal
            |> Position.times 3
            |> Position.add center
        )
    ]
        ++ Figure.cross attrs
            Position.normal
            (Position.bottom Position.normal
                |> Position.times 3
                |> Position.add center
            )


venus attrs center =
    Figure.circle attrs Position.big center
        :: Figure.cross attrs
            Position.normal
            (Position.bottom Position.normal
                |> Position.times 3
                |> Position.add center
            )


earth attrs center =
    Figure.circle attrs Position.big center
        :: Figure.cross attrs
            Position.big
            center


jupiter attrs center =
    Figure.rightHalfCircle attrs
        Position.big
        center
        :: Figure.cross attrs
            Position.big
            (Position.right Position.big
                |> Position.add (Position.bottom Position.big)
                |> Position.add center
            )


neptune attrs center =
    [ Figure.line attrs
        center
        (Position.bottom Position.big
            |> Position.add center
        )
    , Figure.bottomHalfCircle attrs
        Position.big
        center
    ]
        ++ Figure.cross attrs
            Position.normal
            (Position.bottom Position.normal
                |> Position.times 3
                |> Position.add center
            )


saturn attrs center =
    Figure.rightHalfCircle attrs
        Position.big
        center
        :: Figure.cross attrs
            Position.normal
            (Position.top Position.normal
                |> Position.times 3
                |> Position.add center
            )


uranus attrs center =
    [ Figure.rightHalfCircle attrs
        Position.big
        (Position.left Position.big
            |> Position.add center
        )
    , Figure.leftHalfCircle attrs
        Position.big
        (Position.right Position.big
            |> Position.add center
        )
    , Figure.line attrs
        (Position.top Position.big
            |> Position.add center
        )
        (Position.bottom Position.big
            |> Position.add center
        )
    , Figure.circle attrs
        Position.normal
        (Position.bottom Position.normal
            |> Position.times 3
            |> Position.add center
        )
    ]


mars attrs center =
    [ Figure.circle attrs Position.big center
    , Figure.line attrs
        (Position.topRight Position.big
            |> Position.add center
        )
        (Position.topRight Position.big
            |> Position.times 2
            |> Position.add center
        )
    , Figure.line attrs
        (Position.topRight Position.big
            |> Position.times 2
            |> Position.add center
        )
        (Position.topRight Position.big
            |> Position.times 2
            |> Position.add (Position.topLeft Position.normal)
            |> Position.add center
        )
    , Figure.line attrs
        (Position.topRight Position.big
            |> Position.times 2
            |> Position.add center
        )
        (Position.topRight Position.big
            |> Position.times 2
            |> Position.add (Position.bottom Position.normal)
            |> Position.add center
        )
    ]


sun attrs center =
    [ Figure.circle attrs
        Position.big
        center
    , Figure.circle attrs
        Position.tiny
        center
    ]


moon attrs center =
    [ Figure.leftHalfCircle attrs Position.big center ]
