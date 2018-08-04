module Twitch.Helix.Decode exposing
  ( User
  , users
  , sampleUser
  , Follow
  , follows
  , sampleFollow
  , Stream
  , streams
  , sampleStream
  , Game
  , games
  , sampleGame
  , Video
  , videos
  , VideoType(..)
  , Viewable(..)
  , sampleVideo
  , Clip
  , clips
  , sampleClip
  , Token
  , token
  , sampleToken
  )

{-| Decoders for the Helix API.

# Users
@docs User, users

# Follows
@docs Follow, follows

# Streams
@docs Stream, streams

# Games
@docs Game, games

# Videos
@docs Video, VideoType, Viewable, videos

# Clips
@docs Clip, clips

# OAuth tokens
@docs Token, token

# Sample data
@docs sampleToken, sampleUser, sampleStream, sampleGame, sampleFollow, sampleVideo, sampleClip
-}

import Twitch.Parse as Parse

import Json.Decode exposing (..)
import Parser
import Date
import Time exposing (Time)

-------- Users -------

{-| Record for decoded users.
-}
type alias User =
  { id : String
  , login : String
  , displayName : String
  , userType : String
  , broadcasterType : String
  , description : String
  , profileImageUrl : String
  , offlineImageUrl : String
  , viewCount : Int
  , email : Maybe String
  }

{-| Json Decoder for users
-}
users : Decoder (List User)
users =
  field "data" (list user)

user : Decoder User
user =
  succeed User
    |> map2 (|>) (field "id" string)
    |> map2 (|>) (field "login" string)
    |> map2 (|>) (field "display_name" string)
    |> map2 (|>) (field "type" string)
    |> map2 (|>) (field "broadcaster_type" string)
    |> map2 (|>) (field "description" string)
    |> map2 (|>) (field "profile_image_url" string)
    |> map2 (|>) (field "offline_image_url" string)
    |> map2 (|>) (field "view_count" int)
    |> map2 (|>) (maybe (field "email" string))

{-| Sample data for a user
-}
sampleUser : String
sampleUser = """
{"data":[{
   "id":"44322889",
   "login":"dallas",
   "display_name":"dallas",
   "type":"staff",
   "broadcaster_type":"",
   "description":"Just a gamer playing games and chatting. :)",
   "profile_image_url":"https://static-cdn.jtvnw.net/jtv_user_pictures/dallas-profile_image-1a2c906ee2c35f12-300x300.png",
   "offline_image_url":"https://static-cdn.jtvnw.net/jtv_user_pictures/dallas-channel_offline_image-1a2c906ee2c35f12-1920x1080.png",
   "view_count":191836881,
   "email":"login@provider.com"
}]}
"""

-------- Follows -------

{-| Record for a decoded follow
-}
type alias Follow =
  { from_id : String
  , to_id : String
  }

{-| Json Decoder for follows
-}
follows : Decoder (List Follow)
follows =
  field "data" (list follow)

follow : Decoder Follow
follow =
  map2 Follow
    (field "from_id" string)
    (field "to_id" string)

{-| Sample data for follows
-}
sampleFollow : String
sampleFollow = """
{"data":
   [
      {
         "from_id":"171003792",
         "to_id":"23161357",
         "followed_at":"2017-08-22T22:55:24Z"
      },
      {
         "from_id":"113627897",
         "to_id":"23161357",
         "followed_at":"2017-08-22T22:55:04Z"
      },
   ],
   "pagination":{"cursor":"eyJiIjpudWxsLCJhIjoiMTUwMzQ0MTc3NjQyNDQyMjAwMCJ9"}
}
"""

-------- Streams -------

{-| Record for decoded Streams data
-}
type alias Stream =
  { channelId : String
  , userId : String
  , gameId : String
  , communityIds : List String
  , title : String
  , viewerCount : Int
  , startedAt : Time
  , language : String
  , thumbnailUrl : String
  }

{-| Json Decoder from streams
-}
streams : Decoder (List Stream)
streams =
  field "data" (list stream)

stream : Decoder Stream
stream =
  succeed Stream
    |> map2 (|>) (field "id" string)
    |> map2 (|>) (field "user_id" string)
    |> map2 (|>) (field "game_id" string)
    |> map2 (|>) (field "community_ids" (list string))
    |> map2 (|>) (field "title" string)
    |> map2 (|>) (field "viewer_count" int)
    |> map2 (|>) (field "started_at" timeStamp)
    |> map2 (|>) (field "language" string)
    |> map2 (|>) (field "thumbnail_url" string)

{-| Sample data for streams
-}
sampleStream : String
sampleStream = """
{"data":
   [
      {
         "id":"26007494656",
         "user_id":"23161357",
         "game_id":"417752",
         "community_ids":[
            "5181e78f-2280-42a6-873d-758e25a7c313",
            "848d95be-90b3-44a5-b143-6e373754c382",
            "fd0eab99-832a-4d7e-8cc0-04d73deb2e54"
         ],
         "type":"live",
         "title":"Hey Guys, It's Monday - Twitter: @Lirik",
         "viewer_count":32575,
         "started_at":"2017-08-14T16:08:32Z",
         "language":"en",
         "thumbnail_url":"https://static-cdn.jtvnw.net/previews-ttv/live_user_lirik-{width}x{height}.jpg"
      }, 
   ], 
   "pagination":{"cursor":"eyJiIjpudWxsLCJhIjp7Ik9mZnNldCI6MjB9fQ=="}
}
"""

-------- Game -------

{-| Record for decoded Game
-}
type alias Game =
  { id : String
  , name : String
  , boxArtUrl : String
  }

{-| Json Decoder for games
-}
games : Decoder (List Game)
games =
  field "data" (list game)

game : Decoder Game
game =
  map3 Game
    (field "id" string)
    (field "name" string)
    (field "box_art_url" string)

{-| Sample data for games
-}
sampleGame : String
sampleGame = """
{"data":
   [
      {
         "id":"493057",
         "name":"PLAYERUNKNOWN'S BATTLEGROUNDS",
         "box_art_url":"https://static-cdn.jtvnw.net/ttv-boxart/PLAYERUNKNOWN%27S%20BATTLEGROUNDS-{width}x{height}.jpg"
      }
   ]
}
"""

-------- Video -------

{-| Record for decoded videos. viewable, video_type, and duration are lightly interpreted.
-}
type alias Video =
  { id : String
  , userId : String
  , title : String
  , description : String
  , createdAt : Time
  , publishedAt : Time
  , url : String
  , thumbnailUrl : String
  , viewable : Viewable
  , viewCount : Int
  , language : String
  , videoType : VideoType
  , duration : Time
  }

{-| Json Decoder for videos
-}
videos : Decoder (List Video)
videos =
  field "data" (list video)

video : Decoder Video
video =
  succeed Video
    |> map2 (|>) (field "id" string)
    |> map2 (|>) (field "user_id" string)
    |> map2 (|>) (field "title" string)
    |> map2 (|>) (field "description" string)
    |> map2 (|>) (field "created_at" timeStamp)
    |> map2 (|>) (field "published_at" timeStamp)
    |> map2 (|>) (field "url" string)
    |> map2 (|>) (field "thumbnail_url" string)
    |> map2 (|>) (field "viewable" viewable)
    |> map2 (|>) (field "view_count" int)
    |> map2 (|>) (field "language" string)
    |> map2 (|>) (field "type" videoType)
    |> map2 (|>) (field "duration" duration)

{-| Enumerted type for the viewable status
-}
type Viewable
  = Public
  | Private

viewable : Decoder Viewable
viewable =
  string
    |> map (\s -> case s of
      "public" -> Public
      "private" -> Private
      _ -> Private
    )

{-| Enumerated type for video_type attribute, does include an escape hatch in case other types are added in the future.
-}
type VideoType
  = Upload
  | Archive
  | Highlight
  | Other String

videoType : Decoder VideoType
videoType =
  string
    |> map (\s -> case s of
      "upload" -> Upload
      "archive" -> Archive
      "highlight" -> Highlight
      _ -> Other s
    )

{-| Sample data for a video
-}
sampleVideo : String
sampleVideo = """
{
  "data": [{
    "id": "234482848",
    "user_id": "67955580",
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

-------- Clips -------

{-| Record for a decoded clip.
-}
type alias Clip =
  { id : String
  , url : String
  , embedUrl : String
  , broadcasterId : String
  , creatorId : String
  , videoId : String
  , gameId : String
  , language : String
  , title : String
  , viewCount : Int
  , createdAt : Time
  , thumbnailUrl : String
  }

{-| Json Decoder for clips.
-}
clips : Decoder (List Clip)
clips =
  field "data" (list clip)

clip : Decoder Clip
clip =
  succeed Clip
    |> map2 (|>) (field "id" string)
    |> map2 (|>) (field "url" string)
    |> map2 (|>) (field "embed_url" string)
    |> map2 (|>) (field "broadcaster_id" string)
    |> map2 (|>) (field "creator_id" string)
    |> map2 (|>) (field "video_id" string)
    |> map2 (|>) (field "game_id" string)
    |> map2 (|>) (field "language" string)
    |> map2 (|>) (field "title" string)
    |> map2 (|>) (field "view_count" int)
    |> map2 (|>) (field "created_at" timeStamp)
    |> map2 (|>) (field "thumbnail_url" string)

{-| Sample data for a clips.
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
    "creator_id": "53834192",
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

-------- OAuth Tokens -------

{-| Record for decoded OAuth tokens
-}
type alias Token =
  { sub : String
  , iss : String
  , aud : String
  , exp : Int
  , iat : Int
  }

{-| Json Decoder for OAuth tokens.

    userId = token
      |> Maybe.andThen (Result.toMaybe << Jwt.decodeToken Twitch.Helix.Decode.token)
      |> Maybe.map .sub
-}
token : Decoder Token
token =
  map5 Token
    (field "sub" string)
    (field "iss" string)
    (field "aud" string)
    (field "exp" int)
    (field "iat" int)

{-| Sample OAuth token.
-}
sampleToken : String
sampleToken = """{ sub = "12345678", iss = "https://api.twitch.tv/api", aud = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", exp = 1511110246, iat = 1511109346 }"""


duration : Decoder Time
duration =
  string
    |> map (\s -> case Parser.run Parse.duration s of
      Ok d -> d
      Err err ->
        let _ = Debug.log "duration parse error" err in 0
    )

timeStamp : Decoder Time
timeStamp =
  string
    |> andThen (\s -> case Date.fromString s of
      Ok d -> succeed (Date.toTime d)
      Err err -> fail err
    )
