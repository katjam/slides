module Exercises exposing (..)

import Html exposing (Html, a, button, div, h1, h2, h3, hr, img, li, p, span, text, ul)
import Html.Attributes exposing (class, href, src, style)
import Html.Events exposing (onClick)
import Markdown
import SharedType exposing (AnnotateInfo, CustomContent, CustomSlide, EndInfo, StartInfo)
import SliceShow.Content exposing (..)
import SliceShow.Slide exposing (..)
import Time exposing (Posix)


type Section
    = Contents
    | WhatIsElm
    | Syntax
    | Programs
    | HtmlAndCss
    | ErrorsAndDebug
    | Tooling
    | Testing


slideContent : Section -> List ( Bool, List SharedType.CustomContent )
slideContent section =
    case section of
        Contents ->
            [ ( False
              , [ slideHeading "Crash into Elm"
                , bullets
                    [ bullet "What is Elm?"
                    , bullet "Syntax"
                    , bullet "Programs"
                    , bullet "Debugging"
                    , bullet "Testing"
                    , bullet "Tooling"
                    ]
                ]
              )
            ]

        WhatIsElm ->
            [ ( False
              , [ slideHeading "What is Elm?"
                , item (img [ src "/src/images/tea.jpg", style "float" "left", style "width" "50%", style "padding-right" "20px" ] [])
                , bullets
                    [ bullet "1930's Functional"
                    , bullet "1973 ML syntax"
                    , bullet "2012/13 React Elm Typescript Webpack"
                    , bullet "2015 GraphQL Redux"
                    ]
                    |> hide
                , bullets
                    [ bullet "Declarative functional language"
                    , bullet "With strong, static types"
                    , bullet "Designed for modern web user interfaces"
                    ]
                    |> hide
                , bullets
                    [ bullet "create-elm-app 20,960 lines"
                    , bullet "create-react-app 2,652,534 lines"
                    ]
                    |> hide
                ]
              )
            ]

        Syntax ->
            [ ( False
              , [ slideHeading "Syntax"
                , item (h3 [] [ text "Strings, Math & Lists" ])
                , code "elm" """
"Hello " ++ "World!"
> Hello World! : String

5 / 2
> 2.5 : Float

5 // 2
> 2 : Int

names = ["Joe", "Bob", "Jane"]

List.reverse names
> ["Jane", "Bob", "Joe"] : List String

List.length names
> 3 : Int

List.map (\\name -> name ++ "y") names
> ["Joey", "Boby", "Janey"] : List String
"""
                ]
              )
            , ( False
              , [ slideHeading "Syntax"
                , item (h3 [] [ text "Tuples & Records" ])
                , code "elm" """
myFailureTuple = (False, "Oh no!", HomePage)
mySuccessTuple = (True, "Yay!", NextPage)

event = { attendees = 5, name = "Crash into Elm" }

event.name
> "Crash into Elm" : String

.name event
> "Crash into Elm" : String

{ event | attendees = 500 }
> { attendees = 500, name = "Crash into Elm" }
    : { attendees : number, name : String }
"""
                ]
              )
            , ( False
              , [ slideHeading "Syntax"
                , item (h3 [] [ text "Functions!" ])
                , code "elm" """
addTwoString : Int -> Int -> String
addTwoString x y =
    String.fromInt x 
        ++ "+" 
        ++ String.fromInt y 
        ++ "=" 
        ++ String.fromInt (x + y)

addTwoString 2 3
> "2+3=5" : String
"""
                ]
              )
            , ( False
              , [ slideHeading "Syntax"
                , item (h3 [] [ text "Logic" ])
                , code "elm" """
if True then "yes" else "no"
> "yes" : String

case time of
    Morning ->
        "Hello"

    Evening ->
        "Goodbye"

    Midnight ->
        ""
"""
                ]
              )
            , ( False
              , [ slideHeading "Syntax"
                , item (h3 [] [ text "Piping" ])
                , code "elm" """
aFunctionWithManySteps data =
    finallyThisFunction (thenThisFunction (firstThisFunction data))

aFunctionWithManySteps data =
    data
        |> firstThisFunction
        |> thenThisFunction
        |> finallyThisFunction
"""
                ]
              )
            ]

        Programs ->
            [ ( False
              , [ slideHeading "Program types"
                , slideP "https://package.elm-lang.org/packages/elm/browser/latest/Browser"
                , bullets
                    [ bullet "Browser.sandbox"
                    , bullet "Browser.element"
                    , bullet "Browser.document"
                    , bullet "Browser.application"
                    ]
                , item (hr [] [])
                , code "elm" """
sandbox :
    { init : model
    , view : model -> Html msg
    , update : msg -> model -> model
    }
    -> Program () model msg
    """
                , item (hr [] [])
                , code "elm" """
module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, style)
import Html.events exposing (onClick)

-- MODEL


type alias Model =
    { bricks : Int }


model : Model
model =
    { bricks = 0 }



-- UPDATE


type Msg
    = AddOne
    | Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddOne ->
            { model | bricks = model.bricks + 1 }

        Reset ->
            { model | bricks = 0 }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [ style [ ( "padding-left", "2em" ) ] ]
            [ h1 [] [ text "Hello Exeter!" ]
            , h2 [] [ text "Let's count some bricks." ]
            , div [] [ text (toString model.bricks) ]
            , button [ onClick AddOne ] [ text "One more!" ]
            , button [ onClick Reset ] [ text "reset" ]


main =
    Browser.sandbox { model = model, view = view, update = update }

                """
                ]
              )
            ]

        HtmlAndCss ->
            [ ( False
              , [ slideHeading "Html & css"
                , item (h3 [] [ text "Elm core" ])
                , code "elm" """
div [ class "list-of-stuff", style "padding" "20px" ]
    [ h2 [] [ text "Short list of stuff" ]
    , ul []
        [ li [] [ text "Item one" ]
        , li [] [ text "Item two" ]
        , li [] [ text "Item three" ]
        ]
    ]
                """
                , item (hr [] [])
                , item (h3 [] [ text "With elm-css" ])
                , code "elm" """
h2 [ css [ privacyHeadingStyle ] ] [ text "My Privacy Heading" ]

privacyHeadingStyle : Style
privacyHeadingStyle =
    batch
        [ color pureWhite
        , fontSize (rem 1.2)
        , marginTop (rem 1)
        ]

                """
                , item (h3 [] [ text "Mention elm-ui..." ])
                ]
              )
            ]

        ErrorsAndDebug ->
            [ ( False
              , [ slideHeading "Error handling & debugging"
                , item (h3 [] [ text "Maybe" ])
                , code "elm" """
type Maybe a
  = Just a
  | Nothing

type alias User =
  { name : String
  , age : Maybe Int
  }

sue : User
sue =
  { name = "Sue", age = Nothing }

tom : User
tom =
  { name = "Tom", age = Just 24 }

canBuyAlcohol : User -> Bool
canBuyAlcohol user =
  case user.age of
    Nothing ->
      False

    Just age ->
      age >= 21
                """
                ]
              )
            , ( False
              , [ slideHeading "Error handling & debugging"
                , item (h3 [] [ text "Result" ])
                , code "elm" """
type Result error value
  = Ok value
  | Err error

isReasonableAge : String -> Result String Int
isReasonableAge input =
  case String.toInt input of
    Nothing ->
      Err "That is not a number!"

    Just age ->
      if age < 0 then
        Err "Please try again after you are born."

      else if age > 135 then
        Err "Are you some kind of turtle?"

      else
        Ok age
                """
                ]
              )
            , ( False
              , [ slideHeading "Error handling & debugging"
                , item (h3 [] [ text "Custom Types" ])
                , code "elm" """
type Colour
    = Red
    | Green
    | Blue

type Direction
  = FromRight Int
  | FromLeft Int
  | FromTop

type alias LightModel =
    { brightness : Int
    , colour: Colour
    , direction: Direction
    }

type RemoteLight
  = Failure
  | Loading
  | Success LightModel

colourToHex : Colour -> String
colourToHex colour =
    case colour of

        Red ->
            "#ff0000"

        Green ->
            "#00ff00"

        Blue ->
            "#0000ff"

directionToString : Direction -> String
directionToString direction =
    case direction of

        FromRight degrees ->
            String.fromInt degrees ++ " degrees from the right"
        
        FromLeft degrees ->
            String.fromInt degrees ++ " degrees from the left"

        FromTop ->
            "from the top"


viewShine : RemoteLight -> Html Msg
viewShine lightData =
    case lightData of

        Failure ->
            text "Oh no, we can't find your light"

        Loading ->
            text "Just waiting for the light..."

        Success aLight ->
            div [ style "background-color" colourToHex aLight.colour ]
                [ text "Shining from " ++ directionToString ]
"""
                ]
              )
            , ( False
              , [ slideHeading "Error handling & debugging"
                , item (h3 [] [ text "Debug" ])
                , bullets
                    [ bullet "Debug.toString anything"
                    , bullet "Debug.log \"My value\" value"
                    , bullet "Debug.todo \"Add more code later\""
                    ]
                , item (img [ src "/src/images/debugger.png", style "width" "80%" ] [])
                ]
              )
            ]

        Tooling ->
            [ ( False
              , [ slideHeading "Tooling"
                , bullets
                    [ bullet "elm-format"
                    , bullet "elm-analyse"
                    , bullet "elm-review"
                    , bullet "elm-live"
                    , bulletLink "ellie" "https://ellie-app.com/bJSMQz9tydqa1"
                    ]
                ]
              )
            ]

        Testing ->
            [ ( False
              , [ slideHeading "Testing"
                , code "elm" """
suite : Test
suite =
    describe "The String module"
        [ describe "String.reverse" -- Nest as many descriptions as you like.
            [ test "has no effect on a palindrome" <|
                \\_ ->
                    let
                        palindrome =
                            "hannah"
                    in
                        Expect.equal palindrome (String.reverse palindrome)

            -- Expect.equal is designed to be used in pipeline style, like this.
            , test "reverses a known string" <|
                \\_ ->
                    "ABCDEFG"
                        |> String.reverse
                        |> Expect.equal "GFEDCBA"

            -- fuzz runs the test 100 times with randomly-generated inputs!
            , fuzz string "restores the original string if you run it again" <|
                \\randomlyGeneratedString ->
                    randomlyGeneratedString
                        |> String.reverse
                        |> String.reverse
                        |> Expect.equal randomlyGeneratedString
            ]
        ]
                """
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


code : String -> String -> CustomContent
code lang str =
    item (Markdown.toHtml [] ("```" ++ lang ++ "\n" ++ str ++ "\n```"))


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
                        item (text "")
                   , item
                        (div [ class "footer" ]
                            [ text ""
                            ]
                        )
                   ]
            )
        ]
