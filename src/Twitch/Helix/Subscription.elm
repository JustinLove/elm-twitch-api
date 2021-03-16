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

{-| JSON Decoders for Helix Subscription responses

Use these pieces to pull out the parts your application needs.

    import Twitch.Helix.Subscription as Subscription
    import Json.Decode exposing (..)

    subs : Decoder (List Sub)
    subs = Follow.response sub

    sub : Decoder Sub
    sub =
      map3 Sub
        Subscription.userId
        Subscription.userName
        (map planPoints Subscription.tier)

# Field decoders
@docs broadcasterId, broadcasterLogin, broadcasterName, gifterId, gifterLogin, gifterName, isGift, tier, planName, userId, userName, userLogin

# Response decoder
@docs response

# Sample Data
@docs sampleSubscription
-}

import Twitch.Helix as Helix exposing (UserId)

import Json.Decode exposing (..)

{-| Id channel subscribed to
-}
broadcasterId : Decoder UserId
broadcasterId = (field "broadcaster_id" Helix.userId)

{-| Login channel subscribed to
-}
broadcasterLogin : Decoder String
broadcasterLogin = (field "broadcaster_login" string)

{-| Name channel subscribed to
-}
broadcasterName : Decoder String
broadcasterName = (field "broadcaster_name" string)

{-| Id person who gifted the sub, if this is a gift sub
-}
gifterId : Decoder (Maybe UserId)
gifterId = (giftField "gifter_id" Helix.userId)

{-| Login person who gifted the sub, if this is a gift sub
-}
gifterLogin : Decoder (Maybe String)
gifterLogin = (giftField "gifter_login" string)

{-| Name person who gifted the sub, if this is a gift sub
-}
gifterName : Decoder (Maybe String)
gifterName = (giftField "gifter_name" string)

{-| Whether the sub is a gift
-}
isGift : Decoder Bool
isGift = (field "is_gift" bool)

{-| Sub tier, as received from Twitch; we don't do any further translation.
-}
tier : Decoder String
tier = (field "tier" string)

{-| Name of the sub tier
-}
planName : Decoder String
planName = (field "plan_name" string)

{-| Id of the user subscribed
-}
userId : Decoder UserId
userId = (field "user_id" Helix.userId)

{-| Name of the user subscribed
-}
userName : Decoder String
userName = (field "user_name" string)

{-| Login of the user subscribed
-}
userLogin : Decoder String
userLogin = (field "user_login" string)

{-| Decode individual records from the api response using the specified decoder
-}
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

