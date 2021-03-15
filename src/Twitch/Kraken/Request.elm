module Twitch.Kraken.Request exposing (send, twitchHeaders, authHeaders)

{-| Helpers for sending Http requests to the Twitch Kraken ("V5") endpoints.

# Send a Request
@docs send

# Header Helpers
Useful if you need to make your own Http call with additional headers.
@docs twitchHeaders, authHeaders

-}

import Http
import Json.Decode

{-| Send a basic request to the Twitch Kraken ("V5") endpoints. Lightweight wrapper around Http, so you can go back to basics if something else is needed. Auth is a token received from an oauth loop.

    fetchHostsUrl : String -> String
    fetchHostsUrl id =
      "https://api.twitch.tv/kraken/channels/"++id++"/hosts"

    fetchHosts : String -> Cmd Msg
    fetchHosts id =
      Twitch.Kraken.Request.send <|
        { clientId = TwitchId.clientId
        , auth = Nothing
        , decoder = hostsDecoder
        , tagger = Hosts
        , url = (fetchHostsUrl id)
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

    Twitch.Kraken.Request.twitchHeaders clientId auth
-}
twitchHeaders : String -> Maybe String -> List Http.Header
twitchHeaders clientId auth =
  List.append
    [ Http.header "Accept" "application/vnd.twitchtv.v5+json"
    , Http.header "Client-ID" clientId
    ] (authHeaders auth)

{-| Creates the oauth header, given an oauth token.
-}
authHeaders : Maybe String -> List Http.Header
authHeaders auth =
  case auth of
    Just token ->
      [ Http.header "Authorization" ("OAuth "++token) ]
    Nothing ->
      []
