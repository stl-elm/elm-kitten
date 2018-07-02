module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Task
import Window


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { windowWidth : Int
    , windowHeight : Int
    , kittensPerColumn : Int
    , kittensPerRow : Int
    }


type Msg
    = WindowSizeMsg Window.Size


init =
    ( { windowWidth = 0
      , windowHeight = 0
      , kittensPerColumn = 4
      , kittensPerRow = 4
      }
    , Task.perform WindowSizeMsg Window.size
    )



-- VIEWS


view model =
    div []
        [ kittenColumn model
        , userForm model
        ]


kittenColumn model =
    let
        heights =
            -- TODO
            [ 300 ]
    in
    div [ style [ ( "display", "flex" ), ( "flex-direction", "column" ) ] ]
        (List.map (kittenRow model) heights)


kittenRow model height =
    let
        widths =
            -- TODO
            [ 300 ]
    in
    div [ style [ ( "display", "flex" ), ( "flex-direction", "row" ) ] ]
        (List.map (kittenPicture height) widths)


kittenPicture height width =
    img
        [ src
            ("http://placekitten.com/"
                ++ toString width
                ++ "/"
                ++ toString height
            )
        ]
        []


userForm model =
    div [ class "user-form" ]
        [ label [ class "user-input" ] [ text "# columns ", input [ type_ "number" ] [] ]
        , label [ class "user-input" ] [ text "# rows ", input [ type_ "number" ] [] ]
        ]



-- UPDATE


update msg model =
    case msg of
        WindowSizeMsg size ->
            ( { model | windowWidth = size.width, windowHeight = size.height }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions model =
    Sub.none



-- TODO


randomize : Int -> Int -> List Int
randomize size n =
    List.repeat n (size // n)
