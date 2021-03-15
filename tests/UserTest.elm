module UserTest exposing (..)

import Twitch.Helix.User exposing (..)

import Json.Decode
import Time exposing (Posix)

import Expect exposing (Expectation)
import Test exposing (..)

suite : Test
suite = describe "Deserialize"
  [ test "id" <| \_ ->
    decodes id
      ["44322889"]
  , test "login" <| \_ ->
    decodes login
      ["dallas"]
  , test "display name" <| \_ ->
    decodes displayName
      ["dallas"]
  , test "type" <| \_ ->
    decodes userType
      ["staff"]
  , test "broadcaster type" <| \_ ->
    decodes broadcasterType
      [""]
  , test "description" <| \_ ->
    decodes description
      ["Just a gamer playing games and chatting. :)"]
  , test "profile image url" <| \_ ->
    decodes profileImageUrl
      ["https://static-cdn.jtvnw.net/jtv_user_pictures/dallas-profile_image-1a2c906ee2c35f12-300x300.png"]
  , test "offline image url" <| \_ ->
    decodes offlineImageUrl
      ["https://static-cdn.jtvnw.net/jtv_user_pictures/dallas-channel_offline_image-1a2c906ee2c35f12-1920x1080.png"]
  , test "view count" <| \_ ->
    decodes viewCount
      [191836881]
  , test "email present" <| \_ ->
    decodes email
      [Just "login@provider.com"]
  , test "email missing" <| \_ ->
    Expect.equal
      (Json.Decode.decodeString email "{}")
      (Ok Nothing)
  , test "created at" <| \_ ->
    decodes createdAt
      [Time.millisToPosix 1481747548894]
  ]

decodes : Json.Decode.Decoder a -> (List a) -> Expectation
decodes decoder expectation =
  Expect.equal
    (Json.Decode.decodeString (response decoder) sampleUser)
    (Ok expectation)
