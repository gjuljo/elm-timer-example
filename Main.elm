port module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Events exposing (onClick)


type alias Model =
    { currentValue : Int
    }


initialModel : Model
initialModel =
    { currentValue = 0
    }


init : () -> ( Model, Cmd Msg )
init flags =
    ( initialModel, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ text <| String.fromInt model.currentValue
        , br [] []
        , button [ onClick Reset ] [ text "Reset" ]
        ]


type Msg
    = Tick Int
    | Reset


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick _ ->
            ( { model | currentValue = model.currentValue + 1 }, Cmd.none )

        Reset ->
            ( { model | currentValue = 0 }, Cmd.none )


port doTickFromJavaScript : (Int -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions _ =
    doTickFromJavaScript Tick


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }
