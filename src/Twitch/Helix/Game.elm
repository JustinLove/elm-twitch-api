module Twitch.Helix.Game exposing
  ( id
  , name
  , boxArtUrl
  , response
  , sampleGame
  )

import Twitch.Helix as Helix exposing (GameId)

import Json.Decode exposing (..)

id : Decoder GameId
id = (field "id" Helix.gameId)

name : Decoder String
name = (field "name" string)

boxArtUrl : Decoder String
boxArtUrl = (field "box_art_url" string)

response : Decoder a -> Decoder (List a)
response decoder =
  field "data" (list decoder)

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

