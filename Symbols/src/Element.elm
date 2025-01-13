module Element exposing (..)

import Figure
import Position


air attrs center =
    [ Figure.triangleUp attrs Position.big center
    , Figure.line attrs
        (Position.topLeft Position.big
            |> Position.add center
        )
        (Position.topRight Position.big
            |> Position.add center
        )
    ]


earth attrs center =
    [ Figure.triangleDown attrs Position.big center
    , Figure.line attrs
        (Position.bottomLeft Position.big
            |> Position.add center
        )
        (Position.bottomRight Position.big
            |> Position.add center
        )
    ]


fire attrs center =
    [ Figure.triangleUp attrs Position.big center
    ]


water attrs center =
    [ Figure.triangleDown attrs Position.big center
    ]


ather attrs center =
    [ Figure.triangleUp attrs Position.big center
    , Figure.triangleDown attrs Position.big center
    ]
