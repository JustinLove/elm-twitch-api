module Twitch.Kraken.Decode exposing
  ( Host
  , hosts
  , sampleHost
  )

{-| Decoders for the Karken API at `https://api.twitch.tv/kraken/channels/CHANNELID/hosts` Note that this is an unofficial API

@docs Host, hosts, sampleHost

-}

import Json.Decode exposing (..)

{-| Record for decoded host data
-}
type alias Host =
  { hostId : String
  , targetId : String
  }

{-| Json decoder for hosts
-}
hosts : Decoder (List Host)
hosts =
  field "hosts" (list host)

host : Decoder Host
host =
  map2 Host
    (field "host_id" string)
    (field "target_id" string)

{-| sample data for bootstrapping and testing
-}
sampleHost : String
sampleHost = """
{"hosts":[{"host_id":"75917141","target_id":"56623426"},{"host_id":"176430307","target_id":"56623426"},{"host_id":"541255784","target_id":"56623426"},{"host_id":"29051593","target_id":"56623426"},{"host_id":"60671932","target_id":"56623426"},{"host_id":"455624892","target_id":"56623426"},{"host_id":"138565742","target_id":"56623426"},{"host_id":"69626522","target_id":"56623426"},{"host_id":"185855782","target_id":"56623426"},{"host_id":"38079361","target_id":"56623426"},{"host_id":"160473004","target_id":"56623426"},{"host_id":"74138186","target_id":"56623426"},{"host_id":"44315463","target_id":"56623426"},{"host_id":"208158319","target_id":"56623426"},{"host_id":"140571170","target_id":"56623426"},{"host_id":"163420925","target_id":"56623426"},{"host_id":"160577009","target_id":"56623426"},{"host_id":"185833998","target_id":"56623426"},{"host_id":"154305162","target_id":"56623426"},{"host_id":"197231733","target_id":"56623426"},{"host_id":"45782061","target_id":"56623426"},{"host_id":"70534465","target_id":"56623426"},{"host_id":"115982676","target_id":"56623426"},{"host_id":"59716837","target_id":"56623426"},{"host_id":"107252090","target_id":"56623426"},{"host_id":"36610797","target_id":"56623426"}]}
"""

