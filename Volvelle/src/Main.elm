module Main exposing (..)

import Browser
import Html exposing (Html)
import Html.Attributes
import MoonDial
import OuterDial
import SunDial
import Svg
import Svg.Attributes
import Time exposing (Posix)


type alias Model =
    { posix : Posix }


type Msg
    = Tick Posix


size : number
size =
    400


outerDialRadius : Float
outerDialRadius =
    size / 2


sunDialRadius : Float
sunDialRadius =
    outerDialRadius * 3 / 4


moonDialRadius : Float
moonDialRadius =
    sunDialRadius * 3 / 4


moonRadius : Float
moonRadius =
    moonDialRadius / 4


init : () -> ( Model, Cmd Msg )
init () =
    ( { posix = Time.millisToPosix 0 }, Cmd.none )


view : Model -> Html Msg
view model =
    let
        msPerRotation =
            200000

        t =
            Time.posixToMillis model.posix
                |> modBy msPerRotation
                |> toFloat

        rotation =
            t / msPerRotation

        moonCycle =
            rotation * 365 / 30.5

        moonSpeed =
            sunSpeed + 2 * pi * moonCycle

        sunSpeed =
            pi / 2 + 2 * pi * rotation
    in
    [ OuterDial.toSvg
        { radius = outerDialRadius
        , innerRadius = sunDialRadius
        }
        ( size / 2, size / 2 )
    , SunDial.toSvg
        { radius = sunDialRadius
        , innerRadius = moonDialRadius
        , moonRadius = moonRadius
        }
        ( size / 2, size / 2 )
        |> Svg.g
            [ Svg.Attributes.transform
                ("rotate("
                    ++ String.fromFloat (sunSpeed * 360 / (2 * pi))
                    ++ ","
                    ++ String.fromFloat (size / 2)
                    ++ ","
                    ++ String.fromFloat (size / 2)
                    ++ ")"
                )
            ]
        |> List.singleton
    , MoonDial.toSvg
        { radius = moonDialRadius
        , moonRadius = moonRadius
        }
        ( size / 2, size / 2 )
        |> Svg.g
            [ Svg.Attributes.transform
                ("rotate("
                    ++ String.fromFloat (moonSpeed * 360 / (2 * pi))
                    ++ ","
                    ++ String.fromFloat (size / 2)
                    ++ ","
                    ++ String.fromFloat (size / 2)
                    ++ ")"
                )
            ]
        |> List.singleton
    ]
        |> List.concat
        |> Svg.svg
            [ Html.Attributes.width size
            , Html.Attributes.height size
            ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick posix ->
            ( { model | posix = posix }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Time.every 100 Tick


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
