module Counter exposing (Model, Msg, initialModel, update, view)

import Html exposing (Html, button, div, h3, span, text)
import Html.Events exposing (onClick)


type alias Model =
    Int


initialModel : Model
initialModel =
    0


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( model + 1, Cmd.none )

        Decrement ->
            ( model - 1, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ h3 [] [ text "Counter module" ]
        , div []
            [ button [ onClick Increment ] [ text "+" ]
            , span [] [ text (String.fromInt model) ]
            , button [ onClick Decrement ] [ text "-" ]
            ]
        ]
