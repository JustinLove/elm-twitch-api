module Twitch.Helix.User exposing
  ( id
  , login
  , displayName
  , response
  )

import Twitch.Helix as Helix exposing (UserId)

import Json.Decode exposing (..)

id : Decoder UserId
id = (field "id" Helix.userId)

login : Decoder String
login = (field "login" string)

displayName : Decoder String
displayName = (field "display_name" string)

response : Decoder a -> Decoder (List a)
response decoder =
  field "data" (list decoder)
