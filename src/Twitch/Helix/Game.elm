module Twitch.Helix.Game exposing
  ( id
  , name
  , boxArtUrl
  , response
  , sampleGame
  )

{-| JSON Decoders for Helix Game responses

Use these pieces to pull out the parts your application needs.

    import Twitch.Helix.Game as Game
    import Json.Decode exposing (..)

    games : Decoder (List Persist.Game)
    games = Game.response game

    game : Decoder Game
    game =
      map3 Game
        Game.id
        Game.name
        Game.boxArtUrl

# Field decoders
@docs id, name, boxArtUrl

# Response decoder
@docs response

# Sample Data
@docs sampleGame
-}
import Twitch.Helix as Helix exposing (GameId)

import Json.Decode exposing (..)

{-| Id of the game
-}
id : Decoder GameId
id = (field "id" Helix.gameId)

{-| Name of the game
-}
name : Decoder String
name = (field "name" string)

{-| Url for box art images
-}
boxArtUrl : Decoder String
boxArtUrl = (field "box_art_url" string)

{-| Decode individual records from the api response using the specified decoder
-}
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

