module Main exposing (main)

import Browser
import Counter
import Dice
import Html exposing (Html, div, h1, text)
import Timer



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = always ( init, Cmd.none )
        , subscriptions = subscriptions
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { title : String
    , counter : Counter.Model
    , timer : Timer.Model
    , dice : Dice.Model
    }


init : Model
init =
    { title = "Module example"
    , counter = Counter.init
    , timer = Timer.init
    , dice = Dice.init
    }



-- UPDATE


type Msg
    = CounterMsg Counter.Msg
    | TimerMsg Timer.Msg
    | DiceMsg Dice.Msg


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

        DiceMsg subMsg ->
            let
                ( dice, cmd ) =
                    Dice.update subMsg model.dice
            in
            ( { model | dice = dice }, Cmd.map DiceMsg cmd )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map TimerMsg (Timer.subscriptions model.timer) ]



-- VIEW


view : Model -> Html Msg
view { title, counter, timer, dice } =
    div []
        [ h1 [] [ text title ]
        , Html.map CounterMsg (Counter.view counter)
        , Html.map TimerMsg (Timer.view timer)
        , Html.map DiceMsg (Dice.view dice)
        ]
