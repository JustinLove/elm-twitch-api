module Twitch.Kraken.Host exposing
  ( hostId
  , targetId
  , response
  , sampleHost
  )

{-| JSON Decoders for the Kraken API at `https://api.twitch.tv/kraken/channels/CHANNELID/hosts` Note that this is an unofficial API

Use these pieces to pull out the parts your application needs.

    import Twitch.Kraken.Host as Host
    import Json.Decode exposing (..)

    hosts : Decoder (List UserId)
    hosts = Host.response Host.hostId

# Field decoders
@docs hostId, targetId

# Response decoder
@docs response

# Sample Data
@docs sampleHost
-}

import Json.Decode exposing (..)

type alias UserId = String

{-| Id of the channel hosting
-}
hostId : Decoder UserId
hostId = (field "host_id" string)

{-| Id of the channel being hosted
-}
targetId : Decoder UserId
targetId = (field "target_id" string)

{-| Decode individual records from the api response using the specified decoder
-}
response : Decoder a -> Decoder (List a)
response decoder =
  field "hosts" (list decoder)

{-| sample data for bootstrapping and testing
-}
sampleHost : String
sampleHost = """
{"hosts":[{"host_id":"75917141","target_id":"56623426"},{"host_id":"176430307","target_id":"56623426"}]}
"""

