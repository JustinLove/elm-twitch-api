module Twitch.Helix exposing (send, twitchHeaders, authHeaders)

{-| Helpers for sending Http requests to the Twitch Helix ("new Twitch API") endpoints.

# Send a Request
@docs send

# Header Helpers
Useful if you need to make your own Http call with additional headers.
@docs twitchHeaders, authHeaders

-}

import Http
import Json.Decode

{-| Send a basic request to the Twitch Helix ("new Twitch API") endpoints. Lightweight wrapper around Http, so you can go back to basics if something else is needed. Auth is an token received from an oauth loop.

    fetchUserByNameUrl : String -> String
    fetchUserByNameUrl login =
      "https://api.twitch.tv/helix/users?login=" ++ login

    fetchUserByName : String -> Cmd Msg
    fetchUserByName login =
      Twitch.Helix.send <|
        { clientId = TwitchId.clientId
        , auth = Nothing
        , decoder = Twitch.Helix.Decode.users
        , tagger = User
        , url = (fetchUserByNameUrl login)
        }
-}
send :
  { clientId : String
  , auth : Maybe String
  , decoder : Json.Decode.Decoder a
  , tagger : ((Result Http.Error a) -> msg)
  , url : String
  } -> Cmd msg
send {clientId, auth, decoder, tagger, url} =
  Http.send tagger <| Http.request
    { method = "GET"
    , headers = twitchHeaders clientId auth
    , url = url
    , body = Http.emptyBody
    , expect = Http.expectJson decoder
    , timeout = Nothing
    , withCredentials = False
    }

{-| Creates the client-id and outh headers.

    Twitch.Helix.twitchHeaders clientId auth
-}
twitchHeaders : String -> Maybe String -> List Http.Header
twitchHeaders clientId auth =
  List.append
    [ Http.header "Client-ID" clientId
    ] (authHeaders auth)

{-| Creates the oauth header, given an oauth token.
-}
authHeaders : Maybe String -> List Http.Header
authHeaders auth =
  case auth of
    Just token ->
      [ Http.header "Authorization" ("Bearer "++token) ]
    Nothing ->
      []
