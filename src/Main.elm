module Main exposing (..)

import Browser
import Html exposing (Html)
import Html.Attributes
import Maths
import Svg exposing (Svg)
import Svg.Attributes
import Time
import ZodiacCircle


type alias Model =
    { t : Float }


type Msg
    = Tick


svgSize =
    600


planetSize =
    svgSize / 100


useKeplersModel =
    False


init : () -> ( Model, Cmd Msg )
init () =
    ( { t = 4200 }, Cmd.none )


viewCircle : ( Float, Float ) -> Float -> Svg Msg
viewCircle ( x, y ) radius =
    Svg.circle
        [ Svg.Attributes.cx (String.fromFloat x)
        , Svg.Attributes.cy (String.fromFloat y)
        , Svg.Attributes.fill "transparent"
        , Svg.Attributes.stroke "black"
        , Svg.Attributes.r (String.fromFloat radius)
        ]
        []


viewPolygon : ( Float, Float ) -> { points : Int, radius : Float, rotation : Float } -> Svg Msg
viewPolygon center args =
    let
        angle =
            Maths.angleBetweenTwoPointsOfPolygon args.points

        points =
            List.range 0 (args.points - 1)
                |> List.map
                    (\i ->
                        fromPolar ( args.radius, angle * toFloat i + args.rotation )
                            |> Maths.plus center
                    )

        path =
            [ "M"
            , points
                |> List.map
                    (\( x, y ) ->
                        String.fromFloat x
                            ++ " "
                            ++ String.fromFloat y
                    )
                |> String.join " L"
            , " Z"
            ]
                |> String.concat
    in
    Svg.path
        [ Svg.Attributes.d path
        , Svg.Attributes.fill "transparent"
        , Svg.Attributes.stroke "black"
        ]
        []


viewPlanetAt : ( Float, Float ) -> Svg Msg
viewPlanetAt ( x, y ) =
    Svg.circle
        [ Svg.Attributes.cx (String.fromFloat x)
        , Svg.Attributes.cy (String.fromFloat y)
        , Svg.Attributes.r (String.fromFloat planetSize)
        , Svg.Attributes.fill "white"
        , Svg.Attributes.stroke "black"
        ]
        []


viewSun : ( Float, Float ) -> Float -> Svg Msg
viewSun ( x, y ) radius =
    Svg.circle
        [ Svg.Attributes.cx (String.fromFloat x)
        , Svg.Attributes.cy (String.fromFloat y)
        , Svg.Attributes.r (String.fromFloat radius)
        , Svg.Attributes.fill "orange"
        ]
        []


viewMoon : ( Float, Float ) -> Float -> Svg Msg
viewMoon ( x, y ) radius =
    Svg.circle
        [ Svg.Attributes.cx (String.fromFloat x)
        , Svg.Attributes.cy (String.fromFloat y)
        , Svg.Attributes.r (String.fromFloat radius)
        , Svg.Attributes.fill "gray"
        ]
        []


viewEarth : ( Float, Float ) -> Float -> Svg Msg
viewEarth ( x, y ) radius =
    Svg.circle
        [ Svg.Attributes.cx (String.fromFloat x)
        , Svg.Attributes.cy (String.fromFloat y)
        , Svg.Attributes.r (String.fromFloat radius)
        , Svg.Attributes.fill "#9696ff"
        ]
        []


viewLine : ( Float, Float ) -> ( Float, Float ) -> Svg Msg
viewLine ( x1, y1 ) ( x2, y2 ) =
    Svg.line
        [ Svg.Attributes.x1 (String.fromFloat x1)
        , Svg.Attributes.y1 (String.fromFloat y1)
        , Svg.Attributes.x2 (String.fromFloat x2)
        , Svg.Attributes.y2 (String.fromFloat y2)
        , Svg.Attributes.stroke "orange"
        ]
        []


view : Model -> Html Msg
view model =
    let
        center =
            ( svgSize / 2, svgSize / 2 )

        year =
            365.356

        offset =
            fromPolar ( radiusEarth, model.t / year )
                |> Maths.invert

        {--
                |> Maths.plus--}
    in
    [ [ --radiusNeptun
        --, radiusUranus
        --,
        radiusSaturn
      , radiusJupiter
      , radiusMars

      --, radiusEarth
      , radiusVenus
      , radiusMercury
      ]
        |> List.map (viewCircle (Maths.plus center offset))
    , if useKeplersModel then
        {--[ --( radiusNeptun, 3 )
          --, ( radiusUranus, 4 )
          --,--}
        [ radiusSaturn
        , radiusJupiter
        , radiusMars
        , radiusEarth
        , radiusVenus
        ]
            |> List.map
                (\radius ->
                    viewPlanetAt
                        (fromPolar ( radius, model.t ))
                )

      else
        [ ( radiusSaturn, 8, 29.4475 * year )
        , ( radiusJupiter, 7, 11 * year + 315 )
        , ( radiusMars, 6, 686.98 )

        --, ( radiusEarth, 5, year )
        , ( radiusVenus, 4, 224.701 )
        , ( radiusMercury, 3, 87.969 )
        ]
            |> List.concatMap
                (\( radius, n, speed ) ->
                    [ {--viewPolygon (Maths.plus center offset)
                        { points = n
                        , radius = radius
                        , rotation = model.t / speed
                        }
                    , --}
                      viewPlanetAt
                        (fromPolar ( radius, model.t / speed )
                            |> Maths.plus offset
                            |> Maths.plus center
                        )
                    ]
                )
            |> (++)
                [ viewCircle center radiusEarth
                , viewSun (Maths.plus offset center) radiusSun
                , viewLine (Maths.plus offset center)
                    (Maths.invert offset
                        |> Maths.times 3
                        |> Maths.plus center
                    )
                , viewCircle center radiusMoon
                , viewMoon
                    (fromPolar ( radiusMoon, model.t / 27.3217 )
                        |> Maths.plus center
                    )
                    planetSize
                , viewEarth center
                    planetSize
                ]
            |> (++)
                (ZodiacCircle.toSvg
                    { innerRadius = radiusSaturn + radiusEarth
                    , outerRadius = svgSize / 2
                    , center = center
                    }
                )
    ]
        |> List.concat
        |> Svg.svg
            [ Html.Attributes.height svgSize
            , Html.Attributes.width svgSize
            ]



{--radiusNeptun =
    svgSize


radiusUranus =
    Maths.incircleRadiusFromPolygonExcircleRadius 3 radiusNeptun
--}


radiusSaturn =
    svgSize * 3 / 10



--Maths.incircleRadiusFromPolygonExcircleRadius 4 radiusUranus


radiusJupiter =
    if useKeplersModel then
        Maths.incircleRadiusFromCubeExcircleRadius radiusSaturn

    else
        radiusSaturn * 5 / 6



--Maths.incircleRadiusFromPolygonExcircleRadius 8 radiusSaturn


radiusMars =
    if useKeplersModel then
        Maths.incircleRadiusFromTetraederExcircleRadius radiusJupiter

    else
        radiusSaturn * 4 / 6



--Maths.incircleRadiusFromPolygonExcircleRadius 7 radiusJupiter


radiusEarth =
    if useKeplersModel then
        Maths.incircleRadiusFromDodecaederExcircleRadius radiusMars

    else
        radiusSaturn * 3 / 6



--Maths.incircleRadiusFromPolygonExcircleRadius 6 radiusMars


radiusVenus =
    if useKeplersModel then
        Maths.incircleRadiusFromIcosahedronExcircleRadius radiusEarth

    else
        radiusSaturn * 2 / 6



--Maths.incircleRadiusFromPolygonExcircleRadius 5 radiusEarth


radiusMercury =
    if useKeplersModel then
        Maths.incircleRadiusFromOctahedronExcircleRadius radiusVenus

    else
        radiusSaturn / 6



--Maths.incircleRadiusFromPolygonExcircleRadius 4 radiusVenus


radiusSun =
    Maths.incircleRadiusFromPolygonExcircleRadius 3 radiusMercury


radiusMoon =
    radiusSaturn / 12


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick ->
            ( { model | t = model.t + 0.5 }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every 20 (\_ -> Tick)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
