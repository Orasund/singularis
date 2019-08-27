module Singularis.Page.Error exposing (Model,view)

import Dict exposing (Dict)
import Element exposing (Element)
import Singularis.View.Element as Element
import Http exposing (Error(..))

type alias Model =
  Error

view : Error -> Element msg
view error =
  case error of
        BadUrl string ->
          Element.text <| "Bad Url: " ++ string
        Timeout ->
          Element.text <| "Timeout"
        NetworkError ->
          Element.text <| "Network Error"
        BadStatus int ->
          Element.text <| "Bad Status: " ++ (String.fromInt int)
        BadBody string ->
          Element.text <| "Bad Body: " ++ string
  