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

import Twitch.Helix as Helix

import Json.Decode exposing (..)
import Time exposing (Posix)

id : Decoder Helix.VideoId
id = (field "id" Helix.videoId)

userId : Decoder Helix.UserId
userId = (field "user_id" Helix.userId)

userLogin : Decoder String
userLogin = (field "user_login" string)

userName : Decoder String
userName = (field "user_name" string)

title : Decoder String
title = (field "title" string)

description : Decoder String
description = (field "description" string)

createdAt : Decoder Posix
createdAt = (field "created_at" Helix.timeStamp)

publishedAt : Decoder Posix
publishedAt = (field "published_at" Helix.timeStamp)

thumbnailUrl : Decoder String
thumbnailUrl = (field "thumbnail_url" string)

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

viewable : Decoder Viewable
viewable = (field "viewable" viewableDecoder)

viewCount : Decoder Int
viewCount = (field "view_count" int)

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

videoType : Decoder VideoType
videoType = (field "type" videoTypeValue)

duration : Decoder Int
duration = (field "duration" Helix.duration)

response : Decoder a -> Decoder (List a)
response decoder =
  field "data" (list decoder)

{-| Sample data for a video
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
