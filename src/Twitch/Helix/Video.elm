module Twitch.Helix.Video exposing
  ( id
  , userId
  , userLogin
  , userName
  , title
  , description
  , createdAt
  , publishedAt
  , url
  , thumbnailUrl
  , language
  , Viewable(..)
  , viewable
  , viewCount
  , videoType
  , VideoType(..)
  , duration
  , response
  , sampleVideo
  )

{-| JSON Decoders for Helix Video responses

Use these pieces to pull out the parts your application needs.

    import Twitch.Helix.Video as Video
    import Json.Decode exposing (..)

    events : Decoder (List Event)
    events =
      Video.response video
        |> map (List.filterMap (\(videoType, ev) -> if videoType == Video.Archive then Just ev else Nothing))

    video : Decoder (Video.VideoType, Event)
    video =
      map2 Tuple.pair
        Video.videoType
        event

    event : Decoder Event
    event =
      map2 Event
        Video.createdAt
        Video.duration

# Field decoders
@docs id, userId, userLogin, userName, title, description, createdAt, publishedAt, url, thumbnailUrl, language, Viewable, viewable, viewCount, videoType, VideoType, duration

# Response decoder
@docs response

# Sample Data
@docs sampleVideo
-}

import Twitch.Helix as Helix

import Json.Decode exposing (..)
import Time exposing (Posix)

{-| Id of the video
-}
id : Decoder Helix.VideoId
id = (field "id" Helix.videoId)

{-| Id of the channel the video is from
-}
userId : Decoder Helix.UserId
userId = (field "user_id" Helix.userId)

{-| Login of the channel the video is from
-}
userLogin : Decoder String
userLogin = (field "user_login" string)

{-| Name of the channel the video is from
-}
userName : Decoder String
userName = (field "user_name" string)

{-| Title of the video
-}
title : Decoder String
title = (field "title" string)

{-| Description of the video
-}
description : Decoder String
description = (field "description" string)

{-| Time the video was created
-}
createdAt : Decoder Posix
createdAt = (field "created_at" Helix.timeStamp)

{-| Time the video was published
-}
publishedAt : Decoder Posix
publishedAt = (field "published_at" Helix.timeStamp)

{-| Thumbnail
-}
thumbnailUrl : Decoder String
thumbnailUrl = (field "thumbnail_url" string)

{-| Url to view the video
-}
url : Decoder String
url = (field "url" string)

{-| Enumerted type for the viewable status
-}
type Viewable
  = Public
  | Private

viewableDecoder : Decoder Viewable
viewableDecoder =
  string
    |> map (\s -> case s of
      "public" -> Public
      "private" -> Private
      _ -> Private
    )

{-| Whether the video is public or private
-}
viewable : Decoder Viewable
viewable = (field "viewable" viewableDecoder)

{-| Number of views on the video
-}
viewCount : Decoder Int
viewCount = (field "view_count" int)

{-| Language code
-}
language : Decoder String
language = (field "language" string)

{-| Enumerated type for video_type attribute, does include an escape hatch in case other types are added in the future.
-}
type VideoType
  = Upload
  | Archive
  | Highlight
  | Other String

videoTypeValue : Decoder VideoType
videoTypeValue =
  string
    |> map (\s -> case s of
      "upload" -> Upload
      "archive" -> Archive
      "highlight" -> Highlight
      _ -> Other s
    )

{-| Type of the video
-}
videoType : Decoder VideoType
videoType = (field "type" videoTypeValue)

{-| Number of milliseconds, with second accuracy
-}
duration : Decoder Int
duration = (field "duration" Helix.duration)

{-| Decode individual records from the api response using the specified decoder
-}
response : Decoder a -> Decoder (List a)
response decoder =
  field "data" (list decoder)

{-| Sample response for a video
-}
sampleVideo : String
sampleVideo = """
{
  "data": [{
    "id": "234482848",
    "user_id": "67955580",
    "user_login": "chewiemelodies",
    "user_name": "ChewieMelodies",
    "title": "-",
    "description": "",
    "created_at": "2018-03-02T20:53:41Z",
    "published_at": "2018-03-02T20:53:41Z",
    "url": "https://www.twitch.tv/videos/234482848",
    "thumbnail_url": "https://static-cdn.jtvnw.net/s3_vods/bebc8cba2926d1967418_chewiemelodies_27786761696_805342775/thumb/thumb0-%{width}x%{height}.jpg",
    "viewable": "public",
    "view_count": 142,
    "language": "en",
    "type": "archive",
    "duration": "3h8m33s"
  }],
  "pagination":{"cursor":"eyJiIjpudWxsLCJhIjoiMTUwMzQ0MTc3NjQyNDQyMjAwMCJ9"}
}"""
