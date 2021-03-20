module OAuthTest exposing (..)

import Twitch.Id.OAuth exposing (..)

import Json.Decode

import Expect exposing (Expectation)
import Test exposing (..)

suite : Test
suite = describe "Deserialize"
  [ describe "app token"
    [ test "access token" <| \_ ->
      app accessToken
        "0123456789abcdefghijABCDEFGHIJ"
    , test "refresh token" <| \_ ->
      app refreshToken
        "eyJfaWQmNzMtNGCJ9%6VFV5LNrZFUj8oU231/3Aj"
    , test "expires in" <| \_ ->
      app expiresIn
        3600
    , test "scope" <| \_ ->
      app scope
        ["viewing_activity_read"]
    , test "token type" <| \_ ->
      app tokenType
        "bearer"
    ]
  , describe "client token"
    [ test "access token" <| \_ ->
      client accessToken
        "prau3ol6mg5glgek8m89ec2s9q5i3i"
    , test "scope" <| \_ ->
      client scope
        []
    ]
  ]

app = decodes sampleAppOAuth
client = decodes sampleClientOAuth

decodes : String -> Json.Decode.Decoder a -> a -> Expectation
decodes sample decoder expectation =
  Expect.equal
    (Json.Decode.decodeString decoder sample)
    (Ok expectation)
