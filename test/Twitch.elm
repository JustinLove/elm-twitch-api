import Twitch.Helix.Decode exposing
  ( User
  , users
  , sampleUser
  , follows
  , sampleFollow
  , bitsLeaderboard
  , sampleBitsLeaderboard
  )

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
  [ it "deserializes sample user" <|
    decodes <| Json.Decode.decodeString users sampleUser
  , it "deserializes sample follow" <|
    decodes <| Json.Decode.decodeString follows sampleFollow
  , it "deserializes sample bits leaderboard" <|
    decodes <| Json.Decode.decodeString bitsLeaderboard sampleBitsLeaderboard
  ]

decodes : Result Json.Decode.Error a -> Expectation.Expectation
decodes result =
  isTrue (case Debug.log "result" result of
    Ok _ -> True
    Err _ -> False)
