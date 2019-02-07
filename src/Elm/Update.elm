module Update exposing (update)

import Browser.Dom
import Model exposing (..)
import Task



-- update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnInput str ->
            ( { model
                | input = str
              }
            , Cmd.none
            )

        OnEnter ->
            ( { model
                | history = model.history ++ [ parseCommand model.input ]
                , input = ""
              }
            , tarminalJumpToBotton "tarminal"
            )

        OnCommand cmd ->
            ( { model
                | history = model.history ++ [ cmd ]
                , input = ""
              }
            , tarminalJumpToBotton "tarminal"
            )

        Clear ->
            ( { model | history = [], input = "" }
            , Cmd.none
            )

        Tick ->
            ( { model | caret = not model.caret }
            , Cmd.none
            )

        Focus ->
            ( model
            , Task.attempt (\_ -> NoOp) <| Browser.Dom.focus "prompt"
            )

        _ ->
            ( model, Cmd.none )


parseCommand : String -> Commands
parseCommand cmd =
    case cmd of
        "whoami" ->
            WhoAmI

        "work" ->
            Work

        "link" ->
            Link

        "help" ->
            Help

        _ ->
            None cmd


tarminalJumpToBotton : String -> Cmd Msg
tarminalJumpToBotton id =
    Browser.Dom.getViewportOf id
        |> Task.andThen (\info -> Browser.Dom.setViewportOf id 0 info.scene.height)
        |> Task.attempt (\_ -> NoOp)
