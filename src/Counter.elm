module Counter exposing (Model, Msg, initialModel, update, view)

import Html exposing (Html, button, div, h3, span, text)
import Html.Events exposing (onClick)


type alias Model =
    Int


type Msg
    = Increment
    | Decrement


initialModel : Model
initialModel =
    0


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1


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
