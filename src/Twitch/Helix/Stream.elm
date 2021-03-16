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

{-| JSON Decoders for Helix Stream responses

Use these pieces to pull out the parts your application needs.

    import Twitch.Helix.Stream as Stream
    import Json.Decode exposing (..)

    streams : Decoder (List Stream)
    streams = User.response stream

    stream : Decoder Stream
    stream =
      succeed Stream
        |> map2 (|>) Stream.id
        |> map2 (|>) Stream.userId
        |> map2 (|>) Stream.userName
        |> map2 (|>) Stream.gameId
        |> map2 (|>) Stream.viewerCount
        |> map2 (|>) Stream.thumbnailUrl
        |> map2 (|>) Stream.title

# Field decoders
@docs id, userId, userLogin, userName, gameId, gameName, title, viewerCount, startedAt, language, thumbnailUrl, tagIds

# Response decoder
@docs response

# Sample Data
@docs sampleStream
-}

import Twitch.Helix as Helix

import Json.Decode exposing (..)
import Time exposing (Posix)

{-| Id of the stream
-}
id : Decoder Helix.StreamId
id = (field "id" Helix.streamId)

{-| Id of the channel the stream is on
-}
userId : Decoder Helix.UserId
userId = (field "user_id" Helix.userId)

{-| Login of the channel the stream is on
-}
userLogin : Decoder String
userLogin = (field "user_login" string)

{-| Name of the channel the stream is on
-}
userName : Decoder String
userName = (field "user_name" string)

{-| Id of the game currently listed on the stream
-}
gameId : Decoder Helix.GameId
gameId = (field "game_id" Helix.gameId)

{-| Name of the game currently listed on the stream
-}
gameName : Decoder String
gameName = (field "game_name" string)

{-| Title of the stream
-}
title : Decoder String
title = (field "title" string)

{-| Viewer count
-}
viewerCount : Decoder Int
viewerCount = (field "viewer_count" int)

{-| Time the stream started
-}
startedAt : Decoder Posix
startedAt = (field "started_at" Helix.timeStamp)

{-| Language code listed on the stream
-}
language : Decoder String
language = (field "language" string)

{-| Current thumbnail image
-}
thumbnailUrl : Decoder String
thumbnailUrl = (field "thumbnail_url" string)

{-| List of tag ids
-}
tagIds : Decoder (List String)
tagIds = (field "tag_ids" (oneOf [ null [], list string ]))

{-| Decode individual records from the api response using the specified decoder
-}
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

