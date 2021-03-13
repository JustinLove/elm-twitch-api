module Twitch.Helix exposing
  ( UserId
  , userId
  , ClipId
  , clipId
  , send
  , twitchHeaders
  )

{-| Helpers for sending Http requests to the Twitch Helix ("new Twitch API") endpoints.

# Send a Request
@docs send

# Header Helpers
Useful if you need to make your own Http call with additional headers.
@docs twitchHeaders

-}

import Twitch.Helix.Request

import Json.Decode exposing (..)

type alias UserId = String
type alias ClipId = String

userId : Decoder UserId
userId = string

clipId : Decoder ClipId
clipId = string

{-| Send a basic request to the Twitch Helix ("new Twitch API") endpoints. Lightweight wrapper around Http, so you can go back to basics if something else is needed. Auth is a token received from an oauth loop.

    fetchUserByNameUrl : String -> String
    fetchUserByNameUrl login =
      "https://api.twitch.tv/helix/users?login=" ++ login

    fetchUserByName : String -> String -> Cmd Msg
    fetchUserByName auth login =
      Twitch.Helix.send <|
        { clientId = TwitchId.clientId
        , auth = auth
        , decoder = Twitch.Helix.Decode.users
        , tagger = User
        , url = (fetchUserByNameUrl login)
        }
-}
send = Twitch.Helix.Request.send

{-| Creates the client-id and outh headers.

    Twitch.Helix.twitchHeaders clientId auth
-}
twitchHeaders = Twitch.Helix.Request.twitchHeaders
