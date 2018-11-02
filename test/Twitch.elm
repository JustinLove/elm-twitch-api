import Twitch.Helix.Decode exposing (User, users, sampleUser, Video, videos, sampleVideo, paginated)

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
  , it "deserializes sample video" <|
    decodes <| Json.Decode.decodeString videos sampleVideo
  , it "deserializes paginated video" <|
    decodes <| Json.Decode.decodeString (paginated videos) sampleVideo
  ]

decodes : Result Json.Decode.Error a -> Expectation.Expectation
decodes result =
  isTrue (case result of
    Ok _ -> True
    Err _ -> False)
