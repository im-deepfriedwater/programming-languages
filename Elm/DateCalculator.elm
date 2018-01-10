import Html exposing (Html, body, input, text, h1, p)
import Html.Attributes exposing (style, value, type_)
import Html.Events exposing (onInput)
import Warmup exposing (daysBetween)


type alias Model = { from: String, to: String }
type Msg = ChangeFrom String | ChangeTo String

daysBetweenMessage : String -> String -> String
daysBetweenMessage from to =
    case (daysBetween from to) of
        Ok days -> "is " ++ toString days ++ " days"
        Err err -> "is days"

main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }

model : Model
model = { from = "", to = ""}

update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeFrom f -> { model | from = f }
        ChangeTo t -> { model | to = t }

view : Model -> Html Msg
view model =
    body [style [("textAlign", "center"), ("background-color", "linen")]]
        [ h1 [style [("background-color", "cyan"),("font-family", "Avenir"),("font-size", "40px"),("padding", "5px")]] [text "Date Calculator"]
        , p [] [text "From ", input [type_"date", onInput ChangeFrom] []]
        , p [] [text "to ", input [type_"date", onInput ChangeTo] []]
        , p [] [text <| daysBetweenMessage model.from model.to]
        ]
