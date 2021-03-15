module FollowTest exposing (..)

import Twitch.Helix.Follow exposing (..)

import Json.Decode
import Time exposing (Posix)

import Expect exposing (Expectation)
import Test exposing (..)

suite : Test
suite = describe "Deserialize"
  [ test "from id" <| \_ ->
    decodes fromId
      ["171003792", "113627897"]
  , test "from name" <| \_ ->
    decodes fromName
      ["IIIsutha067III", "Birdman616"]
  , test "to id" <| \_ ->
    decodes toId
      ["23161357","23161357"]
  , test "to name" <| \_ ->
    decodes toName
      ["LIRIK", "LIRIK"]
  , test "Followed at" <| \_ ->
    decodes followedAt
      [Time.millisToPosix 1503442524000, Time.millisToPosix 1503442504000]
  ]

decodes : Json.Decode.Decoder a -> (List a) -> Expectation
decodes decoder expectation =
  Expect.equal
    (Json.Decode.decodeString (response decoder) sampleFollow)
    (Ok expectation)
