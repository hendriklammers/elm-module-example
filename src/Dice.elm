module Dice exposing
    ( Model
    , Msg(..)
    , init
    , subscriptions
    , update
    , view
    )

import Html exposing (Html, button, div, h3, text)
import Html.Events exposing (onClick)
import Random


type alias Model =
    List Int


type Msg
    = Roll
    | RandomNumbers (List Int)


init : Model
init =
    []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate RandomNumbers (diceGenerator 2) )

        RandomNumbers dice ->
            ( dice, Cmd.none )


diceGenerator : Int -> Random.Generator (List Int)
diceGenerator amount =
    Random.list amount (Random.int 1 6)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


viewDice : List Int -> Html Msg
viewDice dice =
    div []
        (List.map
            (\d -> div [] [ text (String.fromInt d) ])
            dice
        )


view : Model -> Html Msg
view model =
    div []
        [ h3 [] [ text "Dice module" ]
        , button
            [ onClick Roll ]
            [ text "Roll dice" ]
        , viewDice model
        ]
