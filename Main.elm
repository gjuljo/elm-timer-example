port module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Events exposing (onClick)


type alias Model =
    { currentValue : Int
    }


initialModel : Model
initialModel =
    { currentValue = 99
    }


init : Int -> ( Model, Cmd Msg )
init flags =
    ( { initialModel | currentValue = flags }, Cmd.none )


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
        Tick time ->
            ( { model | currentValue = time }, Cmd.none )

        Reset ->
            ( model, doResetTickFromElm () )


port doTickFromJavaScript : (Int -> msg) -> Sub msg


port doResetTickFromElm : () -> Cmd msg


subscriptions : Model -> Sub Msg
subscriptions model =
    doTickFromJavaScript Tick


main : Program Int Model Msg
main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }
