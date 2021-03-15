module Twitch.Helix exposing
  ( UserId
  , userId
  , ClipId
  , clipId
  , VideoId
  , videoId
  , GameId
  , gameId
  , StreamId
  , streamId
  , timeStamp
  , duration
  )

import Twitch.Parse as Parse

import Iso8601
import Json.Decode exposing (..)
import Parser.Advanced as Parser
import Time exposing (Posix)

type alias UserId = String
userId : Decoder UserId
userId = string

type alias ClipId = String
clipId : Decoder ClipId
clipId = string

type alias VideoId = String
videoId : Decoder VideoId
videoId = string

type alias GameId = String
gameId : Decoder GameId
gameId = string

type alias StreamId = String
streamId : Decoder StreamId
streamId = string

{-| Decode a timestamp value
-}
timeStamp : Decoder Posix
timeStamp = Iso8601.decoder

{-| Decode a duration value of the form 1h23m45s
-}
duration : Decoder Int
duration =
  string
    |> andThen (\s -> case Parser.run Parse.duration s of
      Ok d -> succeed d
      Err err -> fail ("duration parse error" ++ (Parse.deadEndsToString err))
    )
