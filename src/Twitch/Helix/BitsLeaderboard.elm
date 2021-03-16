module Twitch.Helix.BitsLeaderboard exposing
  ( userId
  , userName
  , score
  , rank
  , response
  , sampleBitsLeaderboard
  )

{-| JSON Decoders for Helix Bits Leaderboard responses.

Use these pieces to pull out the parts your application needs.

    import Twitch.Helix.BitsLeaderboard as BitsLeaderboard
    import Json.Decode exposing (..)

    bitsLeaderboard : Decoder (List Cheer)
    bitsLeaderboard = BitsLeaderboard.response bitsLeader

    bitsLeader : Decoder Cheer
    bitsLeader =
      map3 Cheer
        BitsLeaderboard.userId
        BitsLeaderboard.userName
        BitsLeaderboard.score

# Field decoders
@docs userId, userName, score, rank

# Response decoder
@docs response

# Sample Data
@docs sampleBitsLeaderboard

-}

import Twitch.Helix as Helix exposing (UserId)

import Json.Decode exposing (..)

{-| Id of the user on the leaderboard
-}
userId : Decoder UserId
userId = (field "user_id" Helix.userId)

{-| Name of the user on the leaderboard
-}
userName : Decoder String
userName = (field "user_name" string)

{-| Score or bit value
-}
score : Decoder Int
score = (field "score" int)

{-| Leaderboard position
-}
rank : Decoder Int
rank = (field "rank" int)

{-| Decode individual records from the api response using the specified decoder
-}
response : Decoder a -> Decoder (List a)
response decoder =
  field "data" (list decoder)

{-| sample data for bootstrapping and testing
-}
sampleBitsLeaderboard : String
sampleBitsLeaderboard = """
{
    "data": [
        {
            "user_id": "158010205",
            "user_name": "TundraCowboy",
            "rank": 1,
            "score": 12543
        },
        {
            "user_id": "7168163",
            "user_name": "Topramens",
            "rank": 2,
            "score": 6900
        }
    ],
    "date_range": {
        "started_at": "2018-02-05T08:00:00Z",
        "ended_at": "2018-02-12T08:00:00Z"
    },
    "total": 2
}
"""
