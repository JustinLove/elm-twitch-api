module Twitch.Helix.BitsLeaderboard exposing
  ( userId
  , userName
  , score
  , rank
  , response
  , sampleBitsLeaderboard
  )

import Twitch.Helix as Helix exposing (UserId)

import Json.Decode exposing (..)

userId : Decoder UserId
userId = (field "user_id" Helix.userId)

userName : Decoder String
userName = (field "user_name" string)

score : Decoder Int
score = (field "score" int)

rank : Decoder Int
rank = (field "rank" int)

response : Decoder a -> Decoder (List a)
response decoder =
  field "data" (list decoder)

{-| Sample data for bits leaderboard.
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
