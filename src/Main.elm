module Main exposing (main)

import Browser
import Counter
import Html exposing (Html, div, h1, text)



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = always ( initialModel, Cmd.none )
        , subscriptions = always Sub.none
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { title : String
    , counter : Counter.Model
    }


initialModel : Model
initialModel =
    { title = "Module example"
    , counter = Counter.initialModel
    }



-- UPDATE


type Msg
    = CounterMsg Counter.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CounterMsg subMsg ->
            let
                ( counterModel, _ ) =
                    Counter.update subMsg model.counter
            in
            ( { model | counter = counterModel }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view { title, counter } =
    div []
        [ h1 [] [ text title ]
        , Html.map (\msg -> CounterMsg msg) (Counter.view counter)
        ]
