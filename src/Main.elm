module Main exposing (main)

import Browser
import Counter
import Html exposing (Html, div, h1, text)
import Timer



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = always ( initialModel, Cmd.none )
        , subscriptions = subscriptions
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { title : String
    , counter : Counter.Model
    , timer : Timer.Model
    }


initialModel : Model
initialModel =
    { title = "Module example"
    , counter = Counter.initialModel
    , timer = Timer.initialModel
    }



-- UPDATE


type Msg
    = CounterMsg Counter.Msg
    | TimerMsg Timer.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CounterMsg subMsg ->
            ( { model | counter = Counter.update subMsg model.counter }
            , Cmd.none
            )

        TimerMsg subMsg ->
            ( { model | timer = Timer.update subMsg model.timer }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map TimerMsg (Timer.subscriptions model.timer) ]



-- VIEW


view : Model -> Html Msg
view { title, counter, timer } =
    div []
        [ h1 [] [ text title ]
        , Html.map CounterMsg (Counter.view counter)
        , Html.map TimerMsg (Timer.view timer)
        ]
