module Twitch.Helix.Clip exposing
  ( id
  , url
  , embedUrl
  , broadcasterId
  , thumbnailUrl
  , response
  )

import Twitch.Helix as Helix exposing (UserId, ClipId)

import Json.Decode exposing (..)

id : Decoder ClipId
id = (field "id" Helix.clipId)

url : Decoder String
url = (field "url" string)

embedUrl : Decoder String
embedUrl = (field "embed_url" string)

broadcasterId : Decoder UserId
broadcasterId = (field "broadcaster_id" Helix.userId)

thumbnailUrl : Decoder String
thumbnailUrl = (field "thumbnail_url" string)

response : Decoder a -> Decoder (List a)
response decoder =
  field "data" (list decoder)
