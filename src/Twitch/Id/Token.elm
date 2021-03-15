module Twitch.Id.Token exposing
  ( sub
  , iss
  , aud
  , exp
  , iat
  , sampleToken
  )

{-| Json Decoders for OAuth tokens.

    userId = token
      |> Maybe.andThen (Result.toMaybe << Jwt.decodeToken Twitch.Helix.Token.sub)
-}

import Twitch.Helix as Helix

import Json.Decode exposing (..)
import Time exposing (Posix)

sub : Decoder Helix.UserId
sub = (field "sub" Helix.userId)

iss : Decoder String
iss = (field "iss" string)

aud : Decoder String
aud = (field "aud" string)

exp : Decoder Posix
exp = (field "exp" timeStamp)

iat : Decoder Posix
iat = (field "iat" timeStamp)

{-| Sample OAuth token.
-}
sampleToken : String
sampleToken = """{ "sub": "12345678", "iss": "https://api.twitch.tv/api", "aud": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", "exp": 1511110246, "iat": 1511109346 }"""

timeStamp : Decoder Posix
timeStamp = int
  |> map (\x -> x * 1000)
  |> map Time.millisToPosix
