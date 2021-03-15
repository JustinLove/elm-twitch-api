module Twitch.Helix.User exposing
  ( id
  , login
  , displayName
  , userType
  , broadcasterType
  , description
  , profileImageUrl
  , offlineImageUrl
  , viewCount
  , email
  , createdAt
  , response
  , sampleUser
  )

import Twitch.Helix as Helix exposing (UserId)

import Json.Decode exposing (..)
import Time exposing (Posix)

id : Decoder UserId
id = (field "id" Helix.userId)

login : Decoder String
login = (field "login" string)

displayName : Decoder String
displayName = (field "display_name" string)

userType : Decoder String
userType = (field "type" string)

broadcasterType : Decoder String
broadcasterType = (field "broadcaster_type" string)

description : Decoder String
description = (field "description" string)

profileImageUrl : Decoder String
profileImageUrl = (field "profile_image_url" string)

offlineImageUrl : Decoder String
offlineImageUrl = (field "offline_image_url" string)

viewCount : Decoder Int
viewCount = (field "view_count" int)

email : Decoder (Maybe String)
email = (maybe (field "email" string))

createdAt : Decoder Posix
createdAt = (field "created_at" Helix.timeStamp)

response : Decoder a -> Decoder (List a)
response decoder =
  field "data" (list decoder)

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
   "email":"login@provider.com",
   "created_at": "2016-12-14T20:32:28.894263Z"
}]}
"""
