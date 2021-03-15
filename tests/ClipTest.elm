module ClipTest exposing (..)

import Twitch.Helix.Clip exposing (..)

import Json.Decode
import Time exposing (Posix)

import Expect exposing (Expectation)
import Test exposing (..)

suite : Test
suite = describe "Deserialize"
  [ test "id" <| \_ ->
    decodes id
      ["AwkwardHelplessSalamanderSwiftRage"]
  , test "url" <| \_ ->
    decodes url
      ["https://clips.twitch.tv/AwkwardHelplessSalamanderSwiftRage"]
  , test "embed url" <| \_ ->
    decodes embedUrl
      ["https://clips.twitch.tv/embed?clip=AwkwardHelplessSalamanderSwiftRage"]
  , test "broadcaster id" <| \_ ->
    decodes broadcasterId
      ["67955580"]
  , test "broadcaster name" <| \_ ->
    decodes broadcasterName
      ["ChewieMelodies"]
  , test "creator id" <| \_ ->
    decodes creatorId
      ["53834192"]
  , test "creator name" <| \_ ->
    decodes creatorName
      ["BlackNova03"]
  , test "video id" <| \_ ->
    decodes videoId
      ["205586603"]
  , test "game id" <| \_ ->
    decodes gameId
      ["488191"]
  , test "language" <| \_ ->
    decodes language
      ["en"]
  , test "title" <| \_ ->
    decodes title
      ["babymetal"]
  , test "view count" <| \_ ->
    decodes viewCount
      [10]
  , test "created at" <| \_ ->
    decodes createdAt
      [Time.millisToPosix 1512081258000]
  , test "thumbnail url" <| \_ ->
    decodes thumbnailUrl
      ["https://clips-media-assets.twitch.tv/157589949-preview-480x272.jpg"]
  ]

decodes : Json.Decode.Decoder a -> (List a) -> Expectation
decodes decoder expectation =
  Expect.equal
    (Json.Decode.decodeString (response decoder) sampleClip)
    (Ok expectation)
