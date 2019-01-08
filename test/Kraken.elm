import Twitch.Kraken.Decode exposing (Subscription, subscriptions, sampleSubscriptions)

import Expectation exposing (isTrue, isFalse)
import Test exposing (it, describe, Test)
import Runner exposing (runAll)

import Html exposing (Html)
import Json.Decode

eql = Expectation.eql Debug.toString

main : Html msg
main =
  runAll all

all : Test
all = describe "Deserialize"
  [ it "deserializes sample subscriptoin" <|
    decodes <| Json.Decode.decodeString subscriptions sampleSubscriptions
  ]

decodes : Result Json.Decode.Error a -> Expectation.Expectation
decodes result =
  isTrue (case Debug.log "result" result of
    Ok _ -> True
    Err _ -> False)
