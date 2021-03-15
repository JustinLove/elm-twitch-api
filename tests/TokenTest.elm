module TokenTest exposing (..)

import Twitch.Id.Token exposing (..)

import Json.Decode
import Time exposing (Posix)

import Expect exposing (Expectation)
import Test exposing (..)

suite : Test
suite = describe "Deserialize"
  [ test "sub" <| \_ ->
    decodes sub
      "12345678"
  , test "iss" <| \_ ->
    decodes iss
     "https://api.twitch.tv/api"
  , test "aud" <| \_ ->
    decodes aud
     "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  , test "exp" <| \_ ->
    decodes exp
      (Time.millisToPosix 1511110246000)
  , test "iat" <| \_ ->
    decodes iat
      (Time.millisToPosix 1511109346000)
  ]

decodes : Json.Decode.Decoder a -> a -> Expectation
decodes decoder expectation =
  Expect.equal
    (Json.Decode.decodeString decoder sampleToken)
    (Ok expectation)
