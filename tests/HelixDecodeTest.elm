module HelixDecodeTest exposing (..)

import Twitch.Helix.Decode exposing
  ( User
  , users
  , sampleUser
  , follows
  , sampleFollow
  , subscriptions
  , sampleSubscription
  , bitsLeaderboard
  , sampleBitsLeaderboard
  , streams
  , sampleStream
  , clips
  , sampleClip
  )

import Json.Decode

import Expect exposing (Expectation)
import Test exposing (..)

suite : Test
suite = describe "Deserialize"
  [ test "deserializes sample user" <| \_ ->
    decodes <| Json.Decode.decodeString users sampleUser
  , test "deserializes sample follow" <| \_ ->
    decodes <| Json.Decode.decodeString follows sampleFollow
  , test "deserializes sample bits leaderboard" <| \_ ->
    decodes <| Json.Decode.decodeString bitsLeaderboard sampleBitsLeaderboard
  , test "deserializes sample subscription" <| \_ ->
    decodes <| Json.Decode.decodeString subscriptions sampleSubscription
  , test "deserializes sample stream" <| \_ ->
    decodes <| Json.Decode.decodeString streams sampleStream
  , test "deserializes sample clip" <| \_ ->
    decodes <| Json.Decode.decodeString clips sampleClip
  ]

--debug = Debug.log "result"
debug = identity

decodes : Result Json.Decode.Error a -> Expectation
decodes result =
  Expect.true "decodes" (case debug result of
    Ok _ -> True
    Err _ -> False)
