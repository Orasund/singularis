module Maths exposing (..)


angleBetweenTwoPointsOfPolygon : Int -> Float
angleBetweenTwoPointsOfPolygon n =
    2 * pi / toFloat n


incircleRadiusFromPolygonExcircleRadius : Int -> Float -> Float
incircleRadiusFromPolygonExcircleRadius n excircleRadius =
    let
        point1 =
            fromPolar ( excircleRadius, 0 )

        point2 =
            fromPolar ( excircleRadius, angleBetweenTwoPointsOfPolygon n )

        ( incircleRadius, _ ) =
            point1
                |> vectorTo point2
                |> times (1 / 2)
                |> plus point1
                |> toPolar
    in
    incircleRadius


incircleRadiusFromOctahedronExcircleRadius : Float -> Float
incircleRadiusFromOctahedronExcircleRadius excircleRadius =
    let
        incircleRadius =
            excircleRadius * sqrt (1 / 3)
    in
    incircleRadius


incircleRadiusFromTetraederExcircleRadius : Float -> Float
incircleRadiusFromTetraederExcircleRadius excircleRadius =
    let
        incircleRadius =
            excircleRadius / 3
    in
    incircleRadius


incircleRadiusFromCubeExcircleRadius : Float -> Float
incircleRadiusFromCubeExcircleRadius excircleRadius =
    let
        incircleRadius =
            excircleRadius / sqrt 3
    in
    incircleRadius


incircleRadiusFromDodecaederExcircleRadius : Float -> Float
incircleRadiusFromDodecaederExcircleRadius excircleRadius =
    let
        sideLength =
            excircleRadius * 4 / ((sqrt 5 + 1) * sqrt 3)

        incircleRadius =
            sideLength * sqrt (250 + 110 * sqrt 5) / 20
    in
    incircleRadius


incircleRadiusFromIcosahedronExcircleRadius : Float -> Float
incircleRadiusFromIcosahedronExcircleRadius excircleRadius =
    let
        sideLength =
            excircleRadius / (sqrt (10 + 2 * sqrt 5) / 4)

        incircleRadius =
            sqrt 3 * (3 + sqrt 5) * sideLength / 12
    in
    incircleRadius


vectorTo : ( Float, Float ) -> ( Float, Float ) -> ( Float, Float )
vectorTo to from =
    to |> minus from


minus : ( Float, Float ) -> ( Float, Float ) -> ( Float, Float )
minus vector =
    plus (invert vector)


plus : ( Float, Float ) -> ( Float, Float ) -> ( Float, Float )
plus ( x1, y1 ) ( x2, y2 ) =
    ( x1 + x2, y1 + y2 )


times : Float -> ( Float, Float ) -> ( Float, Float )
times amount ( x, y ) =
    ( x * amount, y * amount )


invert : ( Float, Float ) -> ( Float, Float )
invert ( x, y ) =
    ( -x, -y )
