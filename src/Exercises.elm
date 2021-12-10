module Exercises exposing (..)

import Html exposing (Html, a, button, div, h1, h2, hr, img, li, p, span, text, ul)
import Html.Attributes exposing (class, href, src, style)
import Html.Events exposing (onClick)
import Markdown
import SharedType exposing (AnnotateInfo, CustomContent, CustomSlide, EndInfo, StartInfo)
import SliceShow.Content exposing (..)
import SliceShow.Slide exposing (..)
import Time exposing (Posix)


type Section
    = WhatIsElm


slideContent : Section -> List ( Bool, List SharedType.CustomContent )
slideContent section =
    case section of
        WhatIsElm ->
            [ ( True
              , [ slideHeading "Crash into elm"
                ]
              )
            ]



-- Markup helpers


slideHeading : String -> CustomContent
slideHeading title =
    item (h1 [] [ text title ])


slideHr : CustomContent
slideHr =
    item (hr [] [])


slideP : String -> CustomContent
slideP paragraph =
    item (p [] [ text paragraph ])


slidePMarkdown : String -> CustomContent
slidePMarkdown paragraph =
    item (Markdown.toHtml [] paragraph)


timedHeading : String -> String -> String -> CustomContent
timedHeading minutes who heading =
    let
        label =
            if minutes == "1" then
                " minute"

            else
                " minutes"
    in
    container (h2 [])
        [ item (text heading)
        , item (span [ class "who" ] [ text who ])
        , item (span [ class "time" ] [ text (minutes ++ label) ])
        ]


bullets : List CustomContent -> CustomContent
bullets =
    container (ul [])


bullet : String -> CustomContent
bullet str =
    item (li [] [ text str ])


bulletLink : String -> String -> CustomContent
bulletLink str url =
    item (li [] [ a [ href url ] [ text str ] ])


{-| Custom slide that sets the padding and appends the custom content
-}
paddedSlide : ( Bool, List CustomContent ) -> CustomSlide
paddedSlide ( showStopwatch, content ) =
    slide
        [ container
            (div [ class "slides", style "padding" "50px 100px" ])
            (content
                ++ [ if showStopwatch then
                        custom
                            { displayTime = 0
                            , startTime = 0
                            , timerStarted = False
                            }

                     else
                        item (img [ src "icon.png", class "stopwatch" ] [])
                   , item
                        (div [ class "footer" ]
                            [ text "Slides for this workshop: https://runner.code-reading.org"
                            ]
                        )
                   ]
            )
        ]
