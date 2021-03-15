module GameTest exposing (..)

import Twitch.Helix.Game exposing (..)

import Json.Decode

import Expect exposing (Expectation)
import Test exposing (..)

suite : Test
suite = describe "Deserialize"
  [ test "id" <| \_ ->
    decodes id
      ["493057"]
  , test "name" <| \_ ->
    decodes name
      ["PLAYERUNKNOWN'S BATTLEGROUNDS"]
  , test "box art url" <| \_ ->
    decodes boxArtUrl
      ["https://static-cdn.jtvnw.net/ttv-boxart/PLAYERUNKNOWN%27S%20BATTLEGROUNDS-{width}x{height}.jpg"]
  ]

decodes : Json.Decode.Decoder a -> (List a) -> Expectation
decodes decoder expectation =
  Expect.equal
    (Json.Decode.decodeString (response decoder) sampleGame)
    (Ok expectation)
