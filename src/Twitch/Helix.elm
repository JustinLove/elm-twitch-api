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

{-| Types and JSON Decoders for common Helix types

Most ids are numbers as strings; the library uses an aliased string with a custom name for documentation purposes, but treats the ids as opaque tokens.

# Id aliases
@docs UserId, userId, ClipId, clipId, VideoId, videoId, GameId, gameId, StreamId, streamId

# Time decoders
@docs timeStamp, duration
-}

import Twitch.Parse as Parse

import Iso8601
import Json.Decode exposing (..)
import Parser.Advanced as Parser
import Time exposing (Posix)

{-| User id
-}
type alias UserId = String
{-| User id decoder
-}
userId : Decoder UserId
userId = string

{-| Clip id
Unlike most ids, these are not numbers but slugs witha couple of words.
-}
type alias ClipId = String
{-| Clip id decoder
-}
clipId : Decoder ClipId
clipId = string

{-| Video id
-}
type alias VideoId = String
{-| Video id decoder
-}
videoId : Decoder VideoId
videoId = string

{-| Game id
-}
type alias GameId = String
{-| Game id decoder
-}
gameId : Decoder GameId
gameId = string

{-| Stream id
-}
type alias StreamId = String
{-| Stream id decoder
-}
streamId : Decoder StreamId
streamId = string

{-| Decode a timestamp value
Twitch timestamps are ISO 8601 values, we decode them as Time.Posix
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
