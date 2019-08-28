module Singularis.Page.Book exposing (view)

import Dict exposing (Dict)
import Element exposing (Element)
import Http exposing (Error(..))
import Singularis.View.Book as Book
import Singularis.View.Element as Element


view : Float -> Dict String (Element msg)
view scale =
    Dict.fromList <|
        [ ( "book"
          , Book.view "According to all known laws\nof aviation,\n\n  \nthere is no way a bee\nshould be able to fly.\n\n  \nIts wings are too small to get\nits fat little body off the ground.\n\n  \nThe bee, of course, flies anyway\n\n  \nbecause bees don't care\nwhat humans think is impossible.\n\n  \nYellow, black. Yellow, black.\nYellow, black. Yellow, black.\n\n  \nOoh, black and yellow!\nLet's shake it up a little.\n\n  \nBarry! Breakfast is ready!\n\n  \nOoming!\n\n  \nHang on a second.\n\n  \nHello?\n\n  \n- Barry?\n- Adam?\n\n  \n- Oan you believe this is happening?\n- I can't. I'll pick you up.\n\n  \nLooking sharp.\n\n  \nUse the stairs. Your father\npaid good money for those.\n\n  \nSorry. I'm excited.\n\n  \nHere's the graduate.\nWe're very proud of you, son.\n\n  \nA perfect report card, all B's.\n\n  \nVery proud.\n\n  \nMa! I got a thing going here.\n\n  \n- You got lint on your fuzz.\n- Ow! That's me!\n\n  \n- Wave to us! We'll be in row 118,000.\n- Bye!\n\n  \nBarry, I told you,\nstop flying in the house!\n\n  \n- Hey, Adam.\n- Hey, Barry.\n\n  \n- Is that fuzz gel?\n- A little. Special day, graduation.\n\n  \nNever thought I'd make it.\n\n  \nThree days grade school,\nthree days high school.\n\n  \nThose were awkward.\n\n  \nThree days college. I'm glad I took\na day and hitchhiked around the hive.\n\n  \nYou did come back different.\n\n  \n- Hi, Barry.\n- Artie, growing a mustache? Looks good.\n\n  \n- Hear about Frankie?\n- Yeah.\n\n  \n- You going to the funeral?\n- No, I'm not going.\n\n  \nEverybody knows,\nsting someone, you die.\n\n  \nDon't waste it on a squirrel.\nSuch a hothead.\n\n  \nI guess he could have\njust gotten out of the way.\n\n  \nI love this incorporating\nan amusement park into our day.\n\n  \nThat's why we don't need vacations.\n\n  \nBoy, quite a bit of pomp...\nunder the circumstances.\n\n  \n- Well, Adam, today we are men.\n- We are!\n\n  \n- Bee-men.\n- Amen!\n\n  \nHallelujah!\n\n  \nStudents, faculty, distinguished bees,\n\n  \nplease welcome Dean Buzzwell.\n\n  \nWelcome, New Hive Oity\ngraduating class of...\n\n  \n...9:15.\n\n  \nThat concludes our ceremonies.\n\n  \nAnd begins your career\nat Honex Industries!\n\n  \nWill we pick ourjob today?\n\n  \nI heard it's just orientation.\n\n  \nHeads up! Here we go.\n\n  \nKeep your hands and antennas\ninside the tram at all times.\n\n  \n- Wonder what it'll be like?\n- A little scary.\n\n  \nWelcome to Honex,\na division of Honesco\n\n  \nand a part of the Hexagon Group.\n\n  \nThis is it!\n\n  \nWow.\n\n  \nWow."
          )
        ]