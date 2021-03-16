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

{-| JSON Decoders for Helix Clips responses.

Use these pieces to pull out the parts your application needs.

    import Twitch.Helix.Clip as Clip
    import Json.Decode exposing (..)

    clips : Decoder (List Clip)
    clips = Clip.response clip

    clip : Decoder Clip
    clip =
      succeed Clip
        |> map2 (|>) Clip.id
        |> map2 (|>) Clip.url
        |> map2 (|>) Clip.embedUrl
        |> map2 (|>) Clip.broadcasterId
        |> map2 (|>) Clip.thumbnailUrl

# Field decoders
@docs id, url, embedUrl, broadcasterId, broadcasterName, creatorId, creatorName, videoId, gameId, language, title, viewCount, createdAt, thumbnailUrl

# Response decoder
@docs response

# Sample Data
@docs sampleClip

-}

import Twitch.Helix as Helix exposing (UserId, ClipId)

import Json.Decode exposing (..)
import Time exposing (Posix)

{-| Slug id for the clip
-}
id : Decoder ClipId
id = (field "id" Helix.clipId)

{-| Url to view the clip
-}
url : Decoder String
url = (field "url" string)

{-| Url to embend the clip
-}
embedUrl : Decoder String
embedUrl = (field "embed_url" string)

{-| User id of the channel where the clip is from
-}
broadcasterId : Decoder UserId
broadcasterId = (field "broadcaster_id" Helix.userId)

{-| User name of the channel where the clip is from
-}
broadcasterName : Decoder String
broadcasterName = (field "broadcaster_name" string)

{-| User id who clipped it
-}
creatorId : Decoder UserId
creatorId = (field "creator_id" Helix.userId)

{-| User name who clipped it
-}
creatorName : Decoder String
creatorName = (field "creator_name" string)

{-| Id of the video from which the clip was created
-}
videoId : Decoder Helix.VideoId
videoId = (field "video_id" Helix.videoId)

{-| Id of the game on record when the clip was created
-}
gameId : Decoder Helix.GameId
gameId = (field "game_id" Helix.gameId)

{-| Language code of the stream
-}
language : Decoder String
language = (field "language" string)

{-| Title of the clip
-}
title : Decoder String
title = (field "title" string)

{-| Times the clip was viewed
-}
viewCount : Decoder Int
viewCount = (field "view_count" int)

{-| Time the clip was created
-}
createdAt : Decoder Posix
createdAt = (field "created_at" Helix.timeStamp)

{-| Thumbnail url
-}
thumbnailUrl : Decoder String
thumbnailUrl = (field "thumbnail_url" string)

{-| Decode individual records from the api response using the specified decoder
-}
response : Decoder a -> Decoder (List a)
response decoder =
  field "data" (list decoder)

{-| sample data for bootstrapping and testing
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
