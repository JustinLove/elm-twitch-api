module Twitch.Kraken.Decode exposing
  ( Community
  , community
  , sampleCommunity
  , Subscription
  , subscriptions
  , subscription
  , sampleSubscriptions
  )

{-| Decoders for the Kraken API.

# Communities
@docs Community, community

# Subscriptions
@docs Subscription, subscriptions, subscription

# Sample data
@docs sampleCommunity, sampleSubscriptions
-}

import Json.Decode exposing (..)
import Iso8601
import Time exposing (Posix)


-------- Community -------


{-| Record for decoded community.
-}
type alias Community =
  { id : String
  , avatarImageUrl : String
  , coverImageUrl : String
  , description : String
  , descriptionHtml : String
  , language : String
  , name : String
  , ownerId : String
  , rules : String
  , summary : String
  }

{-| Json Decoder for a community
-}
community : Decoder Community
community =
  succeed Community
    |> map2 (|>) (field "_id" string)
    |> map2 (|>) (field "avatar_image_url" string)
    |> map2 (|>) (field "cover_image_url" string)
    |> map2 (|>) (field "description" string)
    |> map2 (|>) (field "description_html" string)
    |> map2 (|>) (field "language" string)
    |> map2 (|>) (field "name" string)
    |> map2 (|>) (field "owner_id" string)
    |> map2 (|>) (field "rules" string)
    |> map2 (|>) (field "summary" string)


{-| Sample data for a community.
-}
sampleCommunity : String
sampleCommunity = """
{
   "_id": "e9f17055-810f-4736-ba40-fba4ac541caa",
   "avatar_image_url": "",
   "cover_image_url": "",
   "description": "# A Dedicated Tester Community.",
   "description_html": "<h3>A Dedicated Tester Community.</h3>\n",
   "language": "EN",
   "name": "DallasTesterCommunity",
   "owner_id": "44322889",
   "rules": "1. Follow the Twitch Rules of Conduct to the letter. 2. Be kind! 3. Respect other humans. 4. Include everyone.",
   "rules_html": "<ol>\n<li>Follow the Twitch Rules of Conduct to the letter. 2. Be kind! 3. Respect other humans. 4. Include everyone.<br></li>\n</ol>\n",
   "summary": "A community for Dallas Tester or a tester community in Dallas?"
}
"""

-------- Subscriptions -------

{-| Record for decoded community.
-}
type alias Subscription =
  { id : String
  , createdAt : Posix
  , subPlan : String
  , subPlanName : String
  , userId : String
  , userBio : String
  , userCreatedAt : Posix
  , userDisplayName : String
  , userLogo : String
  , userName : String
  , userType : String
  , userUpdatedAt : Posix
  }

{-| Json Decoder for a subscriptions response
-}
subscriptions : Decoder (List Subscription)
subscriptions =
  field "subscriptions" (list subscription)

{-| Json Decoder for a subscription
-}
subscription : Decoder Subscription
subscription =
  succeed Subscription
    |> map2 (|>) (field "_id" string)
    |> map2 (|>) (field "created_at" timeStamp)
    |> map2 (|>) (field "sub_plan" string)
    |> map2 (|>) (field "sub_plan_name" string)
    |> map2 (|>) (at ["user", "_id"] string)
    |> map2 (|>) (at ["user", "bio"] string)
    |> map2 (|>) (at ["user", "created_at"] timeStamp)
    |> map2 (|>) (at ["user", "display_name"] string)
    |> map2 (|>) (at ["user", "logo"] string)
    |> map2 (|>) (at ["user", "name"] string)
    |> map2 (|>) (at ["user", "type"] string)
    |> map2 (|>) (at ["user", "updated_at"] timeStamp)

{-| Sample data for a community.
-}
sampleSubscriptions : String
sampleSubscriptions = """
{
    "_total": 4,
    "subscriptions": [
        {
            "_id": "e5e2ddc37e74aa9636625e8d2cc2e54648a30418",
            "created_at": "2016-04-06T04:44:31Z",
            "sub_plan": "1000",
            "sub_plan_name": "Channel Subscription (mr_woodchuck)",
            "user": {
                "_id": "89614178",
                "bio": "Twitch staff member who is a heimerdinger main on the road to diamond.",
                "created_at": "2015-04-26T18:45:34Z",
                "display_name": "Mr_Woodchuck",
                "logo": "https://static-cdn.jtvnw.net/jtv_user_pictures/mr_woodchuck-profile_image-a8b10154f47942bc-300x300.jpeg",
                "name": "mr_woodchuck",
                "type": "staff",
                "updated_at": "2017-04-06T00:14:13Z"
            }
        }
   ]
}
"""

timeStamp : Decoder Posix
timeStamp = Iso8601.decoder
