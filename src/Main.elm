module Main exposing (..)

import Browser
import Html exposing (Html)
import Html.Attributes
import Maths
import Svg exposing (Svg)
import Svg.Attributes


type alias Model =
    { t : Float }


type Msg
    = Tick


svgSize =
    400


planetSize =
    8


useKeplersModel =
    False


init : () -> ( Model, Cmd Msg )
init () =
    ( { t = 0 }, Cmd.none )


viewCircle : Float -> Svg Msg
viewCircle radius =
    Svg.circle
        [ Svg.Attributes.cx "200"
        , Svg.Attributes.cy "200"
        , Svg.Attributes.fill "transparent"
        , Svg.Attributes.stroke "black"
        , Svg.Attributes.r (String.fromFloat radius)
        ]
        []


viewPolygon : Int -> Float -> Svg Msg
viewPolygon n radius =
    let
        angle =
            Maths.angleBetweenTwoPointsOfPolygon n

        points =
            List.range 0 (n - 1)
                |> List.map
                    (\i ->
                        fromPolar ( radius, angle * toFloat i )
                            |> Maths.plus ( svgSize / 2, svgSize / 2 )
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


viewPointAt : ( Float, Float ) -> Svg Msg
viewPointAt ( x, y ) =
    Svg.circle
        [ Svg.Attributes.cx (String.fromFloat (200 + x))
        , Svg.Attributes.cy (String.fromFloat (200 + y))
        , Svg.Attributes.r (String.fromFloat planetSize)
        ]
        []


view : Model -> Html Msg
view model =
    [ [ --radiusNeptun
        --, radiusUranus
        --,
        radiusSaturn
      , radiusJupiter
      , radiusMars
      , radiusEarth
      , radiusVenus
      , radiusMercury
      ]
        |> List.concatMap
            (\radius ->
                [ viewCircle radius
                , viewPointAt (fromPolar ( radius, 0 ))
                ]
            )
    , (if useKeplersModel then
        {--[ --( radiusNeptun, 3 )
          --, ( radiusUranus, 4 )
          --,
          ( radiusSaturn, 6 )
        , ( radiusJupiter, 3 )
        , ( radiusMars, 8 )
        , ( radiusEarth, 6 )
        , ( radiusVenus, 6 )
        ]--}
        []

       else
        [ ( radiusSaturn, 7 )
        , ( radiusJupiter, 6 )
        , ( radiusMars, 5 )
        , ( radiusEarth, 4 )
        , ( radiusVenus, 3 )
        ]
      )
        |> List.map (\( radius, n ) -> viewPolygon n radius)
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
    svgSize / 2 - planetSize



--Maths.incircleRadiusFromPolygonExcircleRadius 4 radiusUranus


radiusJupiter =
    if useKeplersModel then
        Maths.incircleRadiusFromCubeExcircleRadius radiusSaturn

    else
        Maths.incircleRadiusFromPolygonExcircleRadius 7 radiusSaturn


radiusMars =
    if useKeplersModel then
        Maths.incircleRadiusFromTetraederExcircleRadius radiusJupiter

    else
        Maths.incircleRadiusFromPolygonExcircleRadius 6 radiusJupiter


radiusEarth =
    if useKeplersModel then
        Maths.incircleRadiusFromDodecaederExcircleRadius radiusMars

    else
        Maths.incircleRadiusFromPolygonExcircleRadius 5 radiusMars


radiusVenus =
    if useKeplersModel then
        Maths.incircleRadiusFromIcosahedronExcircleRadius radiusEarth

    else
        Maths.incircleRadiusFromPolygonExcircleRadius 4 radiusEarth


radiusMercury =
    if useKeplersModel then
        Maths.incircleRadiusFromOctahedronExcircleRadius radiusVenus

    else
        Maths.incircleRadiusFromPolygonExcircleRadius 3 radiusVenus


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
