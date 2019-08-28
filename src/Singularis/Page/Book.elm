module Singularis.Page.Book exposing (view)

import Dict exposing (Dict)
import Element exposing (Element)
import Singularis.View.Element as Element
import Singularis.View.Book as Book
import Http exposing (Error(..))

view : Float -> Dict String (Element msg)
view scale =
  Dict.fromList <|
    [ ( "book"
      , Book.view "Das ist ein Test.\n ich hoffe dieser Test ist erfolgreich."
      )
    ]