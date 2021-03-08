module KrakenDecodeTest exposing (..)

import Twitch.Kraken.Decode exposing
  ( Host
  , hosts
  , sampleHost
  )

--import Html exposing (Html)
import Json.Decode

import Expect exposing (Expectation)
import Test exposing (..)

suite : Test
suite = describe "Deserialize"
  [ test "deserializes sample host" <| \_ ->
    decodes <| Json.Decode.decodeString hosts sampleHost
  ]

--debug = Debug.log "result"
debug = identity

decodes : Result Json.Decode.Error a -> Expectation
decodes result =
  Expect.true "decodes" (case debug result of
    Ok _ -> True
    Err _ -> False)
