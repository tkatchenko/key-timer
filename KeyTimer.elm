module KeyTimer exposing (..)

import Html exposing (Html, program, div, text)
import Keyboard exposing (KeyCode)
import Task
import Time exposing (Time, now)


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { keys : List KeyPress }


type alias KeyPress =
    { key : KeyCode
    , time : Time
    }


init : ( Model, Cmd Msg )
init =
    ( Model [], Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ text (toString model) ]



-- UPDATE


type Msg
    = KeyMsg KeyCode
    | KeyTimeMsg KeyCode Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyMsg key ->
            ( model, Task.perform (KeyTimeMsg key) Time.now )

        KeyTimeMsg key time ->
            ( { model | keys = model.keys ++ [ { key = key, time = time } ] }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Keyboard.downs KeyMsg
