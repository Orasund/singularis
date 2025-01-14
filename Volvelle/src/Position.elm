module Position exposing (..)


add : ( Float, Float ) -> ( Float, Float ) -> ( Float, Float )
add ( x1, y1 ) ( x2, y2 ) =
    ( x1 + x2, y1 + y2 )
