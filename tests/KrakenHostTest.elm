module KrakenHostTest exposing (..)

import Twitch.Kraken.Host exposing (..)

import Json.Decode

import Expect exposing (Expectation)
import Test exposing (..)

suite : Test
suite = describe "Deserialize"
  [ test "host id" <| \_ ->
    decodes hostId
      ["75917141","176430307"]
  , test "target id" <| \_ ->
    decodes targetId
      ["56623426","56623426"]
  ]

decodes : Json.Decode.Decoder a -> (List a) -> Expectation
decodes decoder expectation =
  Expect.equal
    (Json.Decode.decodeString (response decoder) sampleHost)
    (Ok expectation)
