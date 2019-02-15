module Twitch.Tmi.Decode exposing
  ( HostingTarget
  , hostingTarget
  , Host
  , hosts
  , sampleHost
  )

{-| Decoders for the TMI API at `tmi.twitch.tv/hosts` Note that this is an unofficial API, requests should be made with Http.send rather than Twitch.Helix.send. Furthermore, TMI does not provide cross-origin headers, so a cross-origin proxy may be required.

# For target=id, does not include target login/display name

@docs HostingTarget, hostingTarget, sampleHost

# Full decode with target login/display name

@docs Host, hosts

-}

import Json.Decode exposing (..)

{-| sample data for bootstrapping and testing
-}
sampleHost : String
sampleHost = """
{"hosts":[{"host_id":32472036,"target_id":56623426,"host_login":"makingsofahero","host_display_name":"MakingsOfAHero"},{"host_id":140571170,"target_id":56623426,"host_login":"nedmakesgames","host_display_name":"NedMakesGames"},{"host_id":70534465,"target_id":56623426,"host_login":"mr_niki_","host_display_name":"Mr_Niki_"},{"host_id":69626522,"target_id":56623426,"host_login":"stormyiceleopard","host_display_name":"StormyIceLeopard"},{"host_id":59692084,"target_id":56623426,"host_login":"katnox","host_display_name":"katnox"},{"host_id":44717169,"target_id":56623426,"host_login":"destructively_phased","host_display_name":"Destructively_Phased"},{"host_id":59716837,"target_id":56623426,"host_login":"joey_yt_nl","host_display_name":"Joey_YT_NL"},{"host_id":71883371,"target_id":56623426,"host_login":"x_deadly_taco_x","host_display_name":"x_Deadly_Taco_x"},{"host_id":36610797,"target_id":56623426,"host_login":"doginlake","host_display_name":"DogInLake"},{"host_id":160473004,"target_id":56623426,"host_login":"kurokitsune_","host_display_name":"KuroKitsune_"},{"host_id":176430307,"target_id":56623426,"host_login":"ossorakgaming","host_display_name":"OssorakGaming"},{"host_id":200310628,"target_id":56623426,"host_login":"lizelive","host_display_name":"LizeLive"},{"host_id":44315463,"target_id":56623426,"host_login":"thyloss","host_display_name":"Thyloss"}]}
"""

{-| Record for decoded host data without target name (target=id)
-}
type alias HostingTarget =
  { hostId : String
  , targetId : String
  , hostLogin : String
  , hostDisplayName : String
  }

{-| Json decoder for hosts without target name (target=id)
-}
hostingTarget : Decoder (List HostingTarget)
hostingTarget =
  field "hosts" (list hostForTarget)

hostForTarget : Decoder HostingTarget
hostForTarget =
  map4 HostingTarget
    ((field "host_id" int) |> map String.fromInt)
    ((field "target_id" int) |> map String.fromInt)
    (field "host_login" string)
    (field "host_display_name" string)

{-| Record for decoded host data with target name
-}
type alias Host =
  { hostId : String
  , targetId : String
  , hostLogin : String
  , targetLogin : String
  , hostDisplayName : String
  , targetDisplayName : String
  }

{-| Json decoder for hosts with target name
-}
hosts : Decoder (List Host)
hosts =
  field "hosts" (list host)

host : Decoder Host
host =
  map6 Host
    ((field "host_id" int) |> map String.fromInt)
    ((field "target_id" int) |> map String.fromInt)
    (field "host_login" string)
    (field "target_login" string)
    (field "host_display_name" string)
    (field "target_display_name" string)
