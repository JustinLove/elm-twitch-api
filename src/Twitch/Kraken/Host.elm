module Twitch.Kraken.Host exposing
  ( hostId
  , response
  )

import Json.Decode exposing (..)

type alias UserId = String

hostId : Decoder UserId
hostId = (field "host_id" string)

response : Decoder a -> Decoder (List a)
response decoder =
  field "hosts" (list decoder)
