module BitsLeaderboardTest exposing (..)

import Twitch.Helix.BitsLeaderboard exposing (..)

import Json.Decode

import Expect exposing (Expectation)
import Test exposing (..)

suite : Test
suite = describe "Deserialize"
  [ test "user id" <| \_ ->
    decodes userId
      ["158010205", "7168163"]
  , test "user name" <| \_ ->
    decodes userName
      ["TundraCowboy", "Topramens"]
  , test "user score" <| \_ ->
    decodes score
      [12543, 6900]
  , test "user rank" <| \_ ->
    decodes rank
      [1, 2]
  ]

--debug = Debug.log "result"
debug = identity

decodes : Json.Decode.Decoder a -> (List a) -> Expectation
decodes decoder expectation =
  Expect.equal
    (Json.Decode.decodeString (response decoder) sampleBitsLeaderboard)
    (Ok expectation)
