module Twitch.Helix.Follow exposing
  ( fromId
  , fromName
  , toId
  , toName
  , followedAt
  , response
  , sampleFollow
  )

{-| JSON Decoders for Helix Follow responses

Use these pieces to pull out the parts your application needs.

    import Twitch.Helix.Follow as Follow
    import Json.Decode exposing (..)

    follows : Decoder (List Follow)
    follows = Follow.response follow

    follow : Decoder Follow
    follow =
      map2 Follow
        Follow.fromName
        (map Time.posixToMillis Follow.followedAt)

# Field decoders
@docs fromId, fromName, toId, toName, followedAt

# Response decoder
@docs response

# Sample Data
@docs sampleFollow
-}
import Twitch.Helix as Helix exposing (UserId)

import Json.Decode exposing (..)
import Time exposing (Posix)

{-| Id of the user following
-}
fromId : Decoder UserId
fromId = (field "from_id" Helix.userId)

{-| Name of the user following
-}
fromName : Decoder String
fromName = (field "from_name" string)

{-| Id of the user being followed
-}
toId : Decoder UserId
toId = (field "to_id" Helix.userId)

{-| Name of the user being followed
-}
toName : Decoder String
toName = (field "to_name" string)

{-| Time at which the follow began
-}
followedAt : Decoder Posix
followedAt = (field "followed_at" Helix.timeStamp)

{-| Decode individual records from the api response using the specified decoder
-}
response : Decoder a -> Decoder (List a)
response decoder =
  field "data" (list decoder)

{-| Sample data for follows
-}
sampleFollow : String
sampleFollow = """
{
   "total": 12345,
   "data":
   [
      {
         "from_id": "171003792",
         "from_name": "IIIsutha067III",
         "to_id": "23161357",
         "to_name": "LIRIK",
         "followed_at": "2017-08-22T22:55:24Z"
      },
      {
         "from_id": "113627897",
         "from_name": "Birdman616",
         "to_id": "23161357",
         "to_name": "LIRIK",
         "followed_at": "2017-08-22T22:55:04Z"
      }
   ],
   "pagination":{
     "cursor": "eyJiIjpudWxsLCJhIjoiMTUwMzQ0MTc3NjQyNDQyMjAwMCJ9"
   }
}"""
