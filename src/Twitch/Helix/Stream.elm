module Twitch.Helix.Stream exposing
  ( id
  , userId
  , userLogin
  , userName
  , gameId
  , gameName
  , title
  , viewerCount
  , startedAt
  , language
  , thumbnailUrl
  , tagIds
  , response
  , sampleStream
  )

import Twitch.Helix as Helix

import Json.Decode exposing (..)
import Time exposing (Posix)

id : Decoder Helix.StreamId
id = (field "id" Helix.streamId)

userId : Decoder Helix.UserId
userId = (field "user_id" Helix.userId)

userLogin : Decoder String
userLogin = (field "user_login" string)

userName : Decoder String
userName = (field "user_name" string)

gameId : Decoder Helix.GameId
gameId = (field "game_id" Helix.gameId)

gameName : Decoder String
gameName = (field "game_name" string)

title : Decoder String
title = (field "title" string)

viewerCount : Decoder Int
viewerCount = (field "viewer_count" int)

startedAt : Decoder Posix
startedAt = (field "started_at" Helix.timeStamp)

language : Decoder String
language = (field "language" string)

thumbnailUrl : Decoder String
thumbnailUrl = (field "thumbnail_url" string)

tagIds : Decoder (List String)
tagIds = (field "tag_ids" (oneOf [ null [], list string ]))

response : Decoder a -> Decoder (List a)
response decoder =
  field "data" (list decoder)

{-| Sample data for streams
-}
sampleStream : String
sampleStream = """
{
  "data": [
    {
      "id": "34888049712",
      "user_id": "117521448",
      "user_login": "lackowitz",
      "user_name": "Lackowitz",
      "game_id": "495064",
      "game_name": "Grand Theft Auto V",
      "type": "live",
      "title": "Splatfest Prep Team Chaos | !multi",
      "viewer_count": 8,
      "started_at": "2019-07-13T12:57:25Z",
      "language": "en",
      "thumbnail_url": "https://static-cdn.jtvnw.net/previews-ttv/live_user_lackowitz-{width}x{height}.jpg",
      "tag_ids": [
        "6ea6bca4-4712-4ab9-a906-e3336a9d8039"
      ]
    },
    {
      "id": "35662396160",
      "user_id": "132567750",
      "user_login": "elimere",
      "user_name": "elimere",
      "game_id": "506078",
      "game_name": "Another Game",
      "type": "live",
      "title": "New Hair, who dis? !SUBtember  |!dog | !social ",
      "viewer_count": 0,
      "started_at": "2019-09-15T01:00:27Z",
      "language": "en",
      "thumbnail_url": "https://static-cdn.jtvnw.net/previews-ttv/live_user_elimere-{width}x{height}.jpg",
      "tag_ids": null
    }
  ],
  "pagination": {
    "cursor": "eyJiIjpudWxsLCJhIjp7Ik9mZnNldCI6M319"
  }
}
"""

