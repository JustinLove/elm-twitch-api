module Twitch.ClipsV2.Decode exposing
  ( Clip
  , clip
  , sampleClip
  )

{-| Decoders for the Clips API at `clips.twitch.tv/api/v2/clips/` Note that this is an unofficial API, requests should be made with Http.send rather than Twitch.Helix.send.

@docs Clip, clip, sampleClip
-}

import Json.Decode exposing (..)
import Iso8601
import Time exposing (Posix)
import Dict exposing (Dict)

{-| Sample data
-}
sampleClip : String
sampleClip = """
{
  "broadcaster_channel_url": "https://www.twitch.tv/wondible",
  "broadcaster_display_name": "wondible",
  "broadcaster_id": "56623426",
  "broadcaster_login": "wondible",
  "broadcaster_logo": "https://static-cdn.jtvnw.net/jtv_user_pictures/c68c288f65b5ca77-profile_image-150x150.jpeg",
  "broadcast_id": "28844949408",
  "curator_channel_url": "https://www.twitch.tv/wondible",
  "curator_display_name": "wondible",
  "curator_id": "56623426",
  "curator_login": "wondible",
  "curator_logo": "https://static-cdn.jtvnw.net/jtv_user_pictures/c68c288f65b5ca77-profile_image-150x150.jpeg",
  "preview_image": "https://clips-media-assets2.twitch.tv/AT-cm%7C246334767-preview.jpg",
  "thumbnails": {
    "medium": "https://clips-media-assets2.twitch.tv/AT-cm%7C246334767-preview-480x272.jpg",
    "small": "https://clips-media-assets2.twitch.tv/AT-cm%7C246334767-preview-260x147.jpg",
    "tiny": "https://clips-media-assets2.twitch.tv/AT-cm%7C246334767-preview-86x45.jpg"
    },
    "game": "One Hour One Life",
    "communities": [],
    "created_at": "2018-05-27T02:53:41Z",
    "title": "Killed by my mom... for the third time.",
    "language": "en",
    "url": "https://clips.twitch.tv/PleasantZealousTofuJKanStyle",
    "info_url": "https://clips.twitch.tv/api/v2/clips/PleasantZealousTofuJKanStyle",
    "status_url": "https://clips.twitch.tv/api/v2/clips/PleasantZealousTofuJKanStyle/status",
    "edit_url": "https://clips.twitch.tv/PleasantZealousTofuJKanStyle/edit",
    "vod_id": "265854129",
    "vod_url": "https://www.twitch.tv/videos/265854129?t=1h36m0s",
    "vod_offset": 5760,
    "vod_preview_image_url": "https://static-cdn.jtvnw.net/s3_vods/3626a1b32df5936bc705_wondible_28844949408_871479502/thumb/thumb0-320x240.jpg",
    "embed_url": "https://clips.twitch.tv/embed?clip=PleasantZealousTofuJKanStyle",
    "embed_html": "<iframe src='https://clips.twitch.tv/embed?clip=PleasantZealousTofuJKanStyle' width='640' height='360' frameborder='0' scrolling='no' allowfullscreen='true'></iframe>",
    "view_url": "https://clips.twitch.tv/api/v2/clips/PleasantZealousTofuJKanStyle/view",
    "id": "246334767",
    "slug": "PleasantZealousTofuJKanStyle",
    "duration": 33.1,
    "views": 8
  }
"""

{-| Record for decoded clip data.
-}
type alias Clip =
  { broadcasterChannelUrl : String
  , broadcasterDisplayName : String
  , broadcasterId : String
  , broadcasterLogin : String
  , broadcasterLogo : String
  , broadcastId : String
  , curatorChannelUrl : String
  , curatorDisplayName : String
  , curatorId : String
  , curatorLogin : String
  , curatorLogo : String
  , previewImage : String
  , thumbnails : Dict String String
  , communities : List String
  , createdAt : Posix
  , title : String
  , language : String
  , infoUrl : String
  , statusUrl : String
  , editUrl : String
  , vodId : Maybe String
  , vodUrl : Maybe String
  , vodOffset : Maybe Int
  , vodPreviewImageUrl : Maybe String
  , embedUrl : String
  , embedHtml : String
  , viewUrl : String
  , id : String
  , slug : String
  , duration : Float
  , views : Int
  }

{-| Decoder for a single clip
-}
clip : Decoder Clip
clip =
  succeed Clip
    |> map2 (|>) (field "broadcaster_channel_url" string)
    |> map2 (|>) (field "broadcaster_display_name" string)
    |> map2 (|>) (field "broadcaster_id" string)
    |> map2 (|>) (field "broadcaster_login" string)
    |> map2 (|>) (field "broadcaster_logo" string)
    |> map2 (|>) (field "broadcast_id" string)
    |> map2 (|>) (field "curator_channel_url" string)
    |> map2 (|>) (field "curator_display_name" string)
    |> map2 (|>) (field "curator_id" string)
    |> map2 (|>) (field "curator_login" string)
    |> map2 (|>) (field "curator_logo" string)
    |> map2 (|>) (field "preview_image" string)
    |> map2 (|>) (field "thumbnails" (dict string))
    |> map2 (|>) (oneOf
      [ (field "communities" (list string))
      , (succeed [])
      ])
    |> map2 (|>) (field "created_at" timeStamp)
    |> map2 (|>) (field "title" string)
    |> map2 (|>) (field "language" string)
    |> map2 (|>) (field "info_url" string)
    |> map2 (|>) (field "status_url" string)
    |> map2 (|>) (field "edit_url" string)
    |> map2 (|>) (maybe (field "vod_id" string))
    |> map2 (|>) (maybe (field "vod_url" string))
    |> map2 (|>) (maybe (field "vod_offset" int))
    |> map2 (|>) (maybe (field "vod_preview_image_url" string))
    |> map2 (|>) (field "embed_url" string)
    |> map2 (|>) (field "embed_html" string)
    |> map2 (|>) (field "view_url" string)
    |> map2 (|>) (field "id" string)
    |> map2 (|>) (field "slug" string)
    |> map2 (|>) (field "duration" float)
    |> map2 (|>) (field "views" int)

timeStamp : Decoder Posix
timeStamp = Iso8601.decoder
