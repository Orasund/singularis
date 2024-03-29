module Singularis.Page.Ai exposing (Model, Msg, init, subscriptions, update, view)

import Color
import Dict exposing (Dict)
import Element exposing (Element)
import Element.Background as Background
import Element.Input as Input
import Geometry.Svg as Svg
import Point2d exposing (Point2d)
import Polygon2d exposing (Polygon2d)
import Random exposing (Seed)
import Singularis.Data exposing (maxInformation)
import Singularis.View exposing (svgSize)
import Singularis.View.Ai as Ai
import Singularis.View.Element as Element
import Singularis.View.Polygon as Polygon
import Time
import TypedSvg as Svg
import TypedSvg.Attributes as Attributes
import TypedSvg.Core exposing (Svg)
import TypedSvg.Types as Types
import Vector2d exposing (Vector2d)


type alias Model =
    { seed : Seed
    , time : Float
    , symmetry : Float
    , information : Int
    , infoPerSec : Int
    , energy : Int
    , base : Int
    , lastCicleSym : Float
    , lastCicleInfo : Int
    }


type Msg
    = Tick
    | SecPassed
    | MinPassed
    | SymmetryChanged Float
    | InformationChanged Int
    | BaseChanged Int
    | InfoPerSecChanged Int
    | EnergyChanged Int


init : Seed -> Model
init seed =
    { seed = seed
    , time = 0
    , symmetry = 0
    , information = 2
    , base = 3
    , infoPerSec = 0
    , energy = 0
    , lastCicleSym = 0
    , lastCicleInfo = 2
    }


update : Msg -> Model -> Model
update msg ({ time } as model) =
    case msg of
        Tick ->
            { model | time = time + 0.02 }

        SecPassed ->
            {- information = energy^2 -}
            let
                symmetry : Float
                symmetry =
                    if model.infoPerSec == 0 then
                        0

                    else if model.information > model.energy ^ 2 then
                        (toFloat <| model.energy ^ 2)
                            / (toFloat <| (+) model.infoPerSec <| model.information)

                    else if model.energy ^ 2 > model.information then
                        (toFloat <| model.information)
                            / (toFloat <| (+) model.infoPerSec <| model.energy ^ 2)

                    else if (model.information == 0) && (model.energy ^ 2 == 0) then
                        0

                    else
                        1
            in
            { model
                | symmetry = symmetry
                , information =
                    model.information
                        |> (+)
                            -(round <|
                                (*) (1 - symmetry + model.symmetry / 2) <|
                                    toFloat <|
                                        model.energy
                             )
                        |> (+) ((*) model.infoPerSec <| round <| symmetry)
                        |> (+) model.infoPerSec
                        |> clamp 0 maxInformation
            }

        MinPassed ->
            { model
                | lastCicleSym = model.symmetry
                , lastCicleInfo = model.information
            }

        SymmetryChanged symmetry ->
            { model | symmetry = symmetry }

        InformationChanged information ->
            { model | information = information }

        BaseChanged base ->
            { model | base = base }

        InfoPerSecChanged infoPerSec ->
            { model | infoPerSec = infoPerSec }

        EnergyChanged energy ->
            { model | energy = energy }


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ Time.every 100 (always Tick)
        , Time.every 1000 (always SecPassed)
        , Time.every 10000 (always MinPassed)
        ]


view : Float -> Model -> Dict String (Element Msg)
view scale { seed, time, symmetry, information, base, infoPerSec, energy, lastCicleSym, lastCicleInfo } =
    Dict.fromList <|
        [ ( "game"
          , Element.column [ Element.centerX, Element.width <| Element.fill ] <|
                [ Element.row
                    [ Element.centerX
                    , Element.width <| Element.fill
                    , Element.spaceEvenly
                    ]
                  <|
                    [ Element.column [] <|
                        [ Element.subsection scale <| "Remaining"
                        , Element.section scale <|
                            String.fromInt <|
                                maxInformation
                                    - information
                        ]
                    , Element.el [] <|
                        Element.html <|
                            Ai.view scale
                                { time = time
                                , seed = seed
                                , symmetry = lastCicleSym
                                , base = base
                                }
                            <|
                                lastCicleInfo
                    , Element.column [] <|
                        [ Element.subsection scale <| "Symmetry"
                        , Element.section scale <|
                            (String.fromInt <| round <| (*) 100 <| symmetry)
                                ++ "%"
                        ]
                    ]
                , Input.radioRow
                    [ Element.spaceEvenly
                    , Element.width <| Element.fill
                    ]
                    { onChange = BaseChanged
                    , options =
                        [ Input.option 3 <| Element.text <| "Spirit"
                        , Input.option 4 <| Element.text <| "Matter"
                        , Input.option 6 <| Element.text <| "Knowledge"
                        ]
                    , selected = Just base
                    , label = Input.labelLeft [] <| Element.text <| "Base "
                    }
                , Element.slider scale
                    { onChange = round >> InfoPerSecChanged
                    , label = "Data Per Sec"
                    , min = 0
                    , max = 2 ^ 4
                    , value = toFloat <| infoPerSec
                    }
                , Element.slider scale
                    { onChange = round >> EnergyChanged
                    , label = "Nodes"
                    , min = 0
                    , max = 2 ^ 6
                    , value = toFloat <| energy
                    }
                ]
          )
        , ( "singularity"
          , Element.column [ Element.centerX ]
                [ Element.html <|
                    let
                        size : Float
                        size =
                            svgSize * scale

                        center : Point2d
                        center =
                            Point2d.fromCoordinates ( size / 2, size / 2 )

                        rectangle : Polygon2d
                        rectangle =
                            Polygon.regular
                                { n = 4
                                , scale = size * 3 / 16 - 1
                                , standing = True
                                }
                                ( size / 2, size * 5 / 32 - 1 )
                    in
                    Svg.svg
                        [ Attributes.width <| Types.px <| size
                        , Attributes.height <| Types.px <| size
                        ]
                    <|
                        ([ [ Polygon.regular { n = 12, scale = size / 2, standing = True } ( size / 2, size / 2 )
                           , Polygon.regular { n = 6, scale = size / 4, standing = True } ( size / 2, size / 2 )
                           ]
                         , rectangle
                            |> List.repeat 6
                            |> List.indexedMap
                                (\i -> Polygon2d.rotateAround center (2 * pi * toFloat i / 6))
                         ]
                            |> List.concat
                            |> List.map
                                (Svg.polygon2d
                                    [ Attributes.stroke Color.black
                                    , Attributes.noFill
                                    ]
                                )
                        )
                , Element.el [ Element.centerX ] <| Element.text "Singularity"
                ]
          )
        ]
