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
    { width : Int
    , height : Int
    , kittensPerColumn : Int
    , kittensPerRow : Int
    }


type Msg
    = WindowSize Window.Size


init =
    ( { width = 0
      , height = 0
      , kittensPerColumn = 4
      , kittensPerRow = 4
      }
    , Task.perform WindowSize Window.size
    )


view model =
    kittenColumn model


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


update msg model =
    case msg of
        WindowSize size ->
            ( { model | width = size.width, height = size.height }
            , Cmd.none
            )


subscriptions model =
    Sub.none



-- TODO


randomize : Int -> Int -> List Int
randomize size n =
    List.repeat n (size // n)
