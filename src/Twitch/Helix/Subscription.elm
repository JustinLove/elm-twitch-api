module Twitch.Helix.Subscription exposing
  ( broadcasterId
  , broadcasterLogin
  , broadcasterName
  , gifterId
  , gifterLogin
  , gifterName
  , isGift
  , tier
  , planName
  , userId
  , userName
  , userLogin
  , response
  , sampleSubscription
  )

import Twitch.Helix as Helix exposing (UserId)

import Json.Decode exposing (..)

broadcasterId : Decoder UserId
broadcasterId = (field "broadcaster_id" Helix.userId)

broadcasterLogin : Decoder String
broadcasterLogin = (field "broadcaster_login" string)

broadcasterName : Decoder String
broadcasterName = (field "broadcaster_name" string)

gifterId : Decoder (Maybe UserId)
gifterId = (giftField "gifter_id" Helix.userId)

gifterLogin : Decoder (Maybe String)
gifterLogin = (giftField "gifter_login" string)

gifterName : Decoder (Maybe String)
gifterName = (giftField "gifter_name" string)

isGift : Decoder Bool
isGift = (field "is_gift" bool)

tier : Decoder String
tier = (field "tier" string)

planName : Decoder String
planName = (field "plan_name" string)

userId : Decoder UserId
userId = (field "user_id" Helix.userId)

userName : Decoder String
userName = (field "user_name" string)

userLogin : Decoder String
userLogin = (field "user_login" string)

response : Decoder a -> Decoder (List a)
response decoder =
  field "data" (list decoder)

{-| Sample data for subscriptions
-}
sampleSubscription : String
sampleSubscription = """
{
   "data": [
     {
          "broadcaster_id": "123",
          "broadcaster_login": "test_user",
          "broadcaster_name": "test_user",
          "gifter_id": "",
          "gifter_login": "",
          "gifter_name": "",
          "is_gift": false,
          "tier": "1000",
          "plan_name": "The Ninjas",
          "user_id": "123",
          "user_name": "snoirf",
          "user_login": "snoirf"
     },
    {
      "broadcaster_id": "141981764",
      "broadcaster_login": "twitchdev",
      "broadcaster_name": "TwitchDev",
      "gifter_id": "12826",
      "gifter_login": "twitch",
      "gifter_name": "Twitch",
      "is_gift": true,
      "tier": "1000",
      "plan_name": "Channel Subscription (twitchdev)",
      "user_id": "527115020",
      "user_name": "twitchgaming",
      "user_login": "twitchgaming"
    }
  ],
  "pagination": {
    "cursor": "xxxx"
  }
}
"""

giftField : String -> Decoder a -> Decoder (Maybe a)
giftField fieldName decoder =
  (field "is_gift" bool)
    |> andThen (\gift ->
      if gift then
        (field fieldName decoder) |> map Just
      else
        succeed Nothing
      )

