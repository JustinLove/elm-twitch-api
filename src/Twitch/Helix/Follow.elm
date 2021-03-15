module Twitch.Helix.Follow exposing
  ( fromId
  , fromName
  , toId
  , toName
  , followedAt
  , response
  , sampleFollow
  )

import Twitch.Helix as Helix exposing (UserId)

import Json.Decode exposing (..)
import Time exposing (Posix)

fromId : Decoder UserId
fromId = (field "from_id" Helix.userId)

fromName : Decoder String
fromName = (field "from_name" string)

toId : Decoder UserId
toId = (field "to_id" Helix.userId)

toName : Decoder String
toName = (field "to_name" string)

followedAt : Decoder Posix
followedAt = (field "followed_at" Helix.timeStamp)

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
