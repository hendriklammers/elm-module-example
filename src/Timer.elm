module Timer exposing
    ( Model
    , Msg
    , init
    , subscriptions
    , update
    , view
    )

import Html exposing (Html, button, div, h3, span, text)
import Html.Events exposing (onClick)
import Time


type alias Model =
    { time : Int
    , paused : Bool
    }


type Msg
    = Tick Time.Posix
    | Pause
    | Reset


init : Model
init =
    { time = 0
    , paused = False
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Tick _ ->
            { model | time = model.time + 1 }

        Pause ->
            { model | paused = toggleBool model.paused }

        Reset ->
            { model | time = 0 }


toggleBool : Bool -> Bool
toggleBool value =
    case value of
        True ->
            False

        False ->
            True


subscriptions : Model -> Sub Msg
subscriptions { paused } =
    case paused of
        True ->
            Sub.none

        False ->
            Time.every 1000 Tick


view : Model -> Html Msg
view { paused, time } =
    div []
        [ h3 [] [ text "Timer module" ]
        , span [] [ text (String.fromInt time) ]
        , button
            [ onClick Pause ]
            [ text
                (case paused of
                    True ->
                        "Play"

                    False ->
                        "Pause"
                )
            ]
        , button
            [ onClick Reset ]
            [ text "Reset" ]
        ]
