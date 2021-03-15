module SubscriptionTest exposing (..)

import Twitch.Helix.Subscription exposing (..)

import Json.Decode

import Expect exposing (Expectation)
import Test exposing (..)

suite : Test
suite = describe "Deserialize"
  [ test "broadcaster id" <| \_ ->
    decodes broadcasterId
      ["123", "141981764"]
  , test "broadcaster login" <| \_ ->
    decodes broadcasterLogin
      ["test_user", "twitchdev"]
  , test "broadcaster name" <| \_ ->
    decodes broadcasterName
      ["test_user", "TwitchDev"]
  , test "gifter id" <| \_ ->
    decodes gifterId
      [Nothing, Just "12826"]
  , test "gifter login" <| \_ ->
    decodes gifterLogin
      [Nothing, Just "twitch"]
  , test "gifter name" <| \_ ->
    decodes gifterName
      [Nothing, Just "Twitch"]
  , test "is gift" <| \_ ->
    decodes isGift
      [False, True]
  , test "tier" <| \_ ->
    decodes tier
      ["1000", "1000"]
  , test "plan name" <| \_ ->
    decodes planName
      ["The Ninjas", "Channel Subscription (twitchdev)"]
  , test "user id" <| \_ ->
    decodes userId
      ["123","527115020"]
  , test "user name" <| \_ ->
    decodes userName
      ["snoirf", "twitchgaming"]
  , test "user login" <| \_ ->
    decodes userLogin
      ["snoirf", "twitchgaming"]
  ]

decodes : Json.Decode.Decoder a -> (List a) -> Expectation
decodes decoder expectation =
  Expect.equal
    (Json.Decode.decodeString (response decoder) sampleSubscription)
    (Ok expectation)
