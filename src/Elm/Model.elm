module Model exposing (Commands(..), Model, Msg(..), commandToString, init)

import Browser.Dom
import Task


type alias Model =
    { input : String
    , history : List Commands
    , caret : Bool
    }


type Msg
    = NoOp
    | Tick
    | OnInput String
    | OnEnter
    | OnCommand Commands
    | Focus
    | Clear


type Commands
    = None String
    | Help
    | WhoAmI
    | Work
    | Link


init : () -> ( Model, Cmd Msg )
init _ =
    ( { input = ""
      , history = [ Help ]
      , caret = True
      }
    , Task.attempt (\_ -> NoOp) <| Browser.Dom.focus "prompt"
    )


commandToString : Commands -> String
commandToString cmd =
    case cmd of
        None str ->
            str

        Help ->
            "help"

        WhoAmI ->
            "whoami"

        Work ->
            "work"

        Link ->
            "link"
