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

{-| JSON Decoders for Helix User responses

Use these pieces to pull out the parts your application needs.

    import Twitch.Helix.User as User
    import Json.Decode exposing (..)

    users : Decoder (List User)
    users = User.response user

    user : Decoder User
    user =
      map3 User
        User.id
        User.login
        User.displayName

# Field decoders
@docs id, login, displayName, userType, broadcasterType, description, profileImageUrl, offlineImageUrl, viewCount, email, createdAt

# Response decoder
@docs response

# Sample Data
@docs sampleUser
-}

import Twitch.Helix as Helix exposing (UserId)

import Json.Decode exposing (..)
import Time exposing (Posix)

{-| Id of the user
-}
id : Decoder UserId
id = (field "id" Helix.userId)

{-| Login of the user
-}
login : Decoder String
login = (field "login" string)

{-| Name of the user
-}
displayName : Decoder String
displayName = (field "display_name" string)

{-| Type of the user, e.g. staff
-}
userType : Decoder String
userType = (field "type" string)

{-| Broadcaster type of the user, e.g. affiliate/partner
-}
broadcasterType : Decoder String
broadcasterType = (field "broadcaster_type" string)

{-| User's profile description
-}
description : Decoder String
description = (field "description" string)

{-| Profile image url
-}
profileImageUrl : Decoder String
profileImageUrl = (field "profile_image_url" string)

{-| Channel offline image
-}
offlineImageUrl : Decoder String
offlineImageUrl = (field "offline_image_url" string)

{-| Channel view count
-}
viewCount : Decoder Int
viewCount = (field "view_count" int)

{-| Users's email, if the request had appropriate scope to read it
-}
email : Decoder (Maybe String)
email = (maybe (field "email" string))

{-| Time account created
-}
createdAt : Decoder Posix
createdAt = (field "created_at" Helix.timeStamp)

{-| Decode individual records from the api response using the specified decoder
-}
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
