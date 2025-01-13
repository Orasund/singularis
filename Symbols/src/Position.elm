module Position exposing (..)


normal : Float
normal =
    15


tiny : Float
tiny =
    small / 2


small : Float
small =
    --inner circle of triangle
    normal / 2


big : Float
big =
    normal * 2


giant : Float
giant =
    big * 2


top : Float -> ( Float, Float )
top =
    onHexagon 0


topRight : Float -> ( Float, Float )
topRight =
    onHexagon 1


bottomRight : Float -> ( Float, Float )
bottomRight =
    onHexagon 2


bottom : Float -> ( Float, Float )
bottom =
    onHexagon 3


bottomLeft : Float -> ( Float, Float )
bottomLeft =
    onHexagon 4


topLeft : Float -> ( Float, Float )
topLeft =
    onHexagon 5


left : Float -> ( Float, Float )
left radius =
    ( -radius, 0 )


right : Float -> ( Float, Float )
right radius =
    ( radius, 0 )


onHexagon : Int -> Float -> ( Float, Float )
onHexagon i s =
    fromPolar
        ( s
        , (-pi / 2) + (2 * pi * toFloat i / 6)
        )


add : ( Float, Float ) -> ( Float, Float ) -> ( Float, Float )
add ( x1, y1 ) ( x2, y2 ) =
    ( x1 + x2, y1 + y2 )


sum : List ( Float, Float ) -> ( Float, Float )
sum =
    List.foldl add
        ( 0, 0 )


times : Float -> ( Float, Float ) -> ( Float, Float )
times n ( x, y ) =
    ( n * x, n * y )
