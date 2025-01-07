module Watch exposing (..)

import Browser
import HourDisplay
import Html exposing (Html)
import Html.Attributes
import Maths
import MinuteDisplay
import Svg exposing (Attribute, Svg)
import Svg.Attributes
import Task
import Time exposing (Posix, Zone)


type alias Model =
    { zone : Zone
    , h : Int
    , m : Int
    , s : Int
    , ms : Int
    }


type Msg
    = Tick Posix
    | GetZone Zone


svgSize =
    600


planetSize =
    svgSize / 100


useKeplersModel =
    False


init : () -> ( Model, Cmd Msg )
init () =
    ( { zone = Time.utc
      , h = 0
      , m = 0
      , s = 0
      , ms = 0
      }
    , Time.here
        |> Task.perform GetZone
    )


viewCircle : List (Attribute msg) -> ( Float, Float ) -> Float -> Svg msg
viewCircle attrs ( x, y ) radius =
    Svg.circle
        ([ Svg.Attributes.cx (String.fromFloat x)
         , Svg.Attributes.cy (String.fromFloat y)
         , Svg.Attributes.fill "transparent"
         , Svg.Attributes.stroke "black"
         , Svg.Attributes.r (String.fromFloat radius)
         ]
            ++ attrs
        )
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
        , Svg.Attributes.stroke "black"
        ]
        []


view : Model -> Html Msg
view model =
    let
        center =
            ( svgSize / 2, svgSize / 2 )

        s =
            toFloat (model.s * 1000 + model.ms) / 60000

        m =
            toFloat (model.m * 60000 + model.s * 1000 + model.ms)
                / (60 * 60 * 1000)

        h =
            toFloat
                ((model.h * (60 * 60 * 1000))
                    + (model.m * 60000)
                    + (model.s * 1000)
                    + model.ms
                )
                / (12 * 60 * 60 * 1000)

        hourlyRotation =
            2 * pi * h - pi / 2

        minutelyRotation =
            2 * pi * m - pi / 2

        secondlyRotation =
            2 * pi * s - pi / 2

        {--
                |> Maths.plus--}
    in
    [ MinuteDisplay.toSvg
        { center =
            fromPolar ( svgSize / 2 - widthMinuteDisplay - radiusHours, hourlyRotation )
                |> Maths.invert
                |> Maths.plus center
        , outerRadius = radiusHours
        , innerRadius = radiusHours - widthSecondDisplay
        , rotation = -hourlyRotation
        }
    , [ viewCircle [ Svg.Attributes.fill "orange" ]
            (fromPolar ( svgSize / 2 - widthMinuteDisplay - radiusMinutes, hourlyRotation )
                |> Maths.plus center
            )
            radiusMinutes
      , viewCircle [ Svg.Attributes.fill "orange" ]
            (fromPolar ( svgSize / 2 - widthMinuteDisplay - radiusHours, hourlyRotation )
                |> Maths.invert
                |> Maths.plus center
                |> Maths.plus (fromPolar ( radiusHours - widthSecondDisplay - radiusSeconds, secondlyRotation ) |> Maths.invert)
            )
            radiusSeconds
      , viewCircle [ Svg.Attributes.fill "gray" ]
            (fromPolar ( svgSize / 2 - widthMinuteDisplay - radiusHours, hourlyRotation )
                |> Maths.invert
                |> Maths.plus center
                |> Maths.plus (fromPolar ( radiusSeconds, secondlyRotation ))
            )
            (radiusHours - widthSecondDisplay - radiusSeconds)
      , {--viewLine
            (fromPolar ( svgSize / 2 - widthMinuteDisplay - radiusHours, hourlyRotation )
                |> Maths.invert
                |> Maths.plus center
            )
            (fromPolar ( svgSize / 2 - widthMinuteDisplay - radiusHours, hourlyRotation )
                |> Maths.invert
                |> Maths.plus center
                |> Maths.plus (fromPolar ( radiusHours, -hourlyRotation ))
            )
      ,--}
        viewLine
            (fromPolar ( svgSize / 2 - widthMinuteDisplay - radiusMinutes, hourlyRotation )
                |> Maths.plus center
            )
            (fromPolar ( svgSize / 2 - widthMinuteDisplay - radiusMinutes, hourlyRotation )
                |> Maths.plus center
                |> Maths.plus (fromPolar ( radiusMinutes, minutelyRotation ))
            )
      ]
    , HourDisplay.toSvg
        { innerRadius = svgSize / 2 - widthMinuteDisplay
        , outerRadius = svgSize / 2
        , center = center
        }
    ]
        |> List.concat
        |> Svg.svg
            [ Html.Attributes.height svgSize
            , Html.Attributes.width svgSize
            ]


widthMinuteDisplay =
    svgSize / 10


widthSecondDisplay =
    radiusHours / 10


radiusCounterSeconds =
    radiusSeconds * 60


radiusSeconds =
    (radiusHours - widthSecondDisplay) / 61


radiusMinutes =
    (svgSize / 2 - widthMinuteDisplay) / 13


radiusHours =
    radiusMinutes * 12


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick posix ->
            let
                h =
                    Time.toHour model.zone posix
                        |> modBy 12

                m =
                    Time.toMinute model.zone posix

                s =
                    Time.toSecond model.zone posix

                ms =
                    Time.toMillis model.zone posix
            in
            ( { model
                | h = h
                , m = m
                , s = s
                , ms = ms
              }
            , Cmd.none
            )

        GetZone zone ->
            ( { model | zone = zone }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every 20 Tick


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
