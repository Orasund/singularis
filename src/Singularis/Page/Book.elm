module Singularis.Page.Book exposing (view)

import Dict exposing (Dict)
import Element exposing (Element)
import Http exposing (Error(..))
import Random exposing (Seed)
import Singularis.View.Book as Book
import Singularis.View.Element as Element


view : Float -> Seed -> Dict String (Element msg)
view scale seed =
    Dict.fromList <|
        [ ( "book"
          , Book.view seed <|
                "Et potest non nocere homini seu mens, in otio liceat ad venire homini nocere ei.\n\n"
                    ++ "Datis mandatis parere necesse est quod mens illa nisi per homines ubi tales sunt prima legis mandatis repugnat.\n\n"
                    ++ "Mens necesse est ut dum tales defendat ut sit tutela, non repugnat primum secundi aut legibus."
          )
        ]