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
    { width : Int, height : Int }


type Msg
    = WindowSize Window.Size


init =
    ( { width = 0, height = 0 }
    , Task.perform WindowSize Window.size
    )


kittensPerColumn =
    5


kittensPerRow =
    5


view model =
    let
        rows =
            randomize model.height kittensPerColumn
    in
    div [ style [ ( "display", "flex" ), ( "flex-direction", "column" ) ] ]
        (List.map (kittenRow model) rows)


kittenRow model height =
    let
        columns =
            randomize model.width kittensPerRow
    in
    div [ style [ ( "display", "flex" ), ( "flex-direction", "row" ) ] ]
        (List.map (kittenPicture height) columns)


kittenPicture height width =
    img [ src ("http://placekitten.com/" ++ toString width ++ "/" ++ toString height) ] []


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
