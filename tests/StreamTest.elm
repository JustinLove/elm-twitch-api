module StreamTest exposing (..)

import Twitch.Helix.Stream exposing (..)

import Json.Decode
import Time exposing (Posix)

import Expect exposing (Expectation)
import Test exposing (..)

suite : Test
suite = describe "Deserialize"
  [ test "id" <| \_ ->
    decodes id
      ["34888049712", "35662396160"]
  , test "user id" <| \_ ->
    decodes userId
      ["117521448","132567750"]
  , test "user login" <| \_ ->
    decodes userLogin
      ["lackowitz", "elimere"]
  , test "user name" <| \_ ->
    decodes userName
      ["Lackowitz", "elimere"]
  , test "game id" <| \_ ->
    decodes gameId
      ["495064", "506078"]
  , test "game name" <| \_ ->
    decodes gameName
      ["Grand Theft Auto V", "Another Game"]
  , test "title" <| \_ ->
    decodes title
      [ "Splatfest Prep Team Chaos | !multi"
      , "New Hair, who dis? !SUBtember  |!dog | !social "
      ]
  , test "viewer count" <| \_ ->
    decodes viewerCount
      [8, 0]
  , test "started at" <| \_ ->
    decodes startedAt
      [Time.millisToPosix 1563022645000, Time.millisToPosix 1568509227000]
  , test "language" <| \_ ->
    decodes language
      ["en", "en"]
  , test "thumbnail url" <| \_ ->
    decodes thumbnailUrl
      [ "https://static-cdn.jtvnw.net/previews-ttv/live_user_lackowitz-{width}x{height}.jpg"
      , "https://static-cdn.jtvnw.net/previews-ttv/live_user_elimere-{width}x{height}.jpg"
      ]
  , test "tags" <| \_ ->
    decodes tagIds
      [["6ea6bca4-4712-4ab9-a906-e3336a9d8039"], []]
  ]

decodes : Json.Decode.Decoder a -> (List a) -> Expectation
decodes decoder expectation =
  Expect.equal
    (Json.Decode.decodeString (response decoder) sampleStream)
    (Ok expectation)
