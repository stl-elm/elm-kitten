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


view model =
    kittenColumn model


kittenColumn model =
    let
        heights =
            randomize model.windowHeight model.kittensPerColumn
    in
    div [ style [ ( "display", "flex" ), ( "flex-direction", "column" ) ] ]
        (List.map (kittenRow model) heights)


kittenRow model height =
    let
        widths =
            randomize model.windowWidth model.kittensPerRow
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


update msg model =
    case msg of
        WindowSizeMsg size ->
            ( { model | windowWidth = size.width, windowHeight = size.height }
            , Cmd.none
            )


subscriptions model =
    Window.resizes WindowSizeMsg



-- TODO


randomize : Int -> Int -> List Int
randomize size n =
    List.repeat n (size // n)
