module Twitch.Helix.Clip exposing
  ( id
  , url
  , embedUrl
  , broadcasterId
  , broadcasterName
  , creatorId
  , creatorName
  , videoId
  , gameId
  , language
  , title
  , viewCount
  , createdAt
  , thumbnailUrl
  , response
  , sampleClip
  )

import Twitch.Helix as Helix exposing (UserId, ClipId)

import Json.Decode exposing (..)
import Time exposing (Posix)

id : Decoder ClipId
id = (field "id" Helix.clipId)

url : Decoder String
url = (field "url" string)

embedUrl : Decoder String
embedUrl = (field "embed_url" string)

broadcasterId : Decoder UserId
broadcasterId = (field "broadcaster_id" Helix.userId)

broadcasterName : Decoder String
broadcasterName = (field "broadcaster_name" string)

creatorId : Decoder UserId
creatorId = (field "creator_id" Helix.userId)

creatorName : Decoder String
creatorName = (field "creator_name" string)

videoId : Decoder Helix.VideoId
videoId = (field "video_id" Helix.videoId)

gameId : Decoder Helix.GameId
gameId = (field "game_id" Helix.gameId)

language : Decoder String
language = (field "language" string)

title : Decoder String
title = (field "title" string)

viewCount : Decoder Int
viewCount = (field "view_count" int)

createdAt : Decoder Posix
createdAt = (field "created_at" Helix.timeStamp)

thumbnailUrl : Decoder String
thumbnailUrl = (field "thumbnail_url" string)

response : Decoder a -> Decoder (List a)
response decoder =
  field "data" (list decoder)

{-| Sample data for a clip.
-}
sampleClip : String
sampleClip = """
{
  "data":
  [{
    "id": "AwkwardHelplessSalamanderSwiftRage",
    "url": "https://clips.twitch.tv/AwkwardHelplessSalamanderSwiftRage",
    "embed_url": "https://clips.twitch.tv/embed?clip=AwkwardHelplessSalamanderSwiftRage",
    "broadcaster_id": "67955580",
    "broadcaster_name": "ChewieMelodies",
    "creator_id": "53834192",
    "creator_name": "BlackNova03",
    "video_id": "205586603",
    "game_id": "488191",
    "language": "en",
    "title": "babymetal",
    "view_count": 10,
    "created_at": "2017-11-30T22:34:18Z",
    "thumbnail_url": "https://clips-media-assets.twitch.tv/157589949-preview-480x272.jpg"
  }]
}
"""
