module Twitch.Helix exposing (send, twitchHeaders)

{-| Helpers for sending Http requests to the Twitch Helix ("new Twitch API") endpoints.

# Send a Request
@docs send

# Header Helpers
Useful if you need to make your own Http call with additional headers.
@docs twitchHeaders

-}

import Http
import Json.Decode

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
send :
  { clientId : String
  , auth : String
  , decoder : Json.Decode.Decoder a
  , tagger : ((Result Http.Error a) -> msg)
  , url : String
  } -> Cmd msg
send {clientId, auth, decoder, tagger, url} =
  Http.request
    { method = "GET"
    , headers = twitchHeaders clientId auth
    , url = url
    , body = Http.emptyBody
    , expect = Http.expectJson tagger decoder
    , timeout = Nothing
    , tracker = Nothing
    }

{-| Creates the client-id and outh headers.

    Twitch.Helix.twitchHeaders clientId auth
-}
twitchHeaders : String -> String -> List Http.Header
twitchHeaders clientId token =
  [ Http.header "Client-ID" clientId
  , Http.header "Authorization" ("Bearer "++token)
  ]
