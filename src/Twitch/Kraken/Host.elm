module Twitch.Kraken.Host exposing
  ( hostId
  , targetId
  , response
  , sampleHost
  )

import Json.Decode exposing (..)

type alias UserId = String

hostId : Decoder UserId
hostId = (field "host_id" string)

targetId : Decoder UserId
targetId = (field "target_id" string)

response : Decoder a -> Decoder (List a)
response decoder =
  field "hosts" (list decoder)

{-| sample data for bootstrapping and testing
-}
sampleHost : String
sampleHost = """
{"hosts":[{"host_id":"75917141","target_id":"56623426"},{"host_id":"176430307","target_id":"56623426"}]}
"""

