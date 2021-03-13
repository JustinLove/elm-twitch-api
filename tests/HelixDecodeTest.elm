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
  , duration
  , timeStamp
  )

import Json.Decode

import Expect exposing (Expectation)
import Test exposing (..)

suite : Test
suite = describe "Deserialize"
  [ describe "full records"
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
  , describe "type decoders"
    [ test "decode duration" <| \_ ->
      Expect.equal
        (Ok ((60 * 60 * 11 + 60 * 2 + 3) * 1000))
        (Json.Decode.decodeString duration "\"11h02m3s\"")
    ]
  ]

--debug = Debug.log "result"
debug = identity

decodes : Result Json.Decode.Error a -> Expectation
decodes result =
  Expect.true "decodes" (case debug result of
    Ok _ -> True
    Err _ -> False)
