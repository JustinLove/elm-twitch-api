module VideoTest exposing (..)

import Twitch.Helix.Video exposing (..)

import Json.Decode
import Time exposing (Posix)

import Expect exposing (Expectation)
import Test exposing (..)

suite : Test
suite = describe "Deserialize"
  [ test "id" <| \_ ->
    decodes id
      ["234482848"]
  , test "user id" <| \_ ->
    decodes userId
      ["67955580"]
  , test "user login" <| \_ ->
    decodes userLogin
      ["chewiemelodies"]
  , test "user name" <| \_ ->
    decodes userName
      ["ChewieMelodies"]
  , test "title" <| \_ ->
    decodes title
      [ "-" ]
  , test "description" <| \_ ->
    decodes description
      [ "" ]
  , test "created at" <| \_ ->
    decodes createdAt
      [Time.millisToPosix 1520024021000]
  , test "published at" <| \_ ->
    decodes publishedAt
      [Time.millisToPosix 1520024021000]
  , test "url" <| \_ ->
    decodes url
      ["https://www.twitch.tv/videos/234482848"]
  , test "thumbnail url" <| \_ ->
    decodes thumbnailUrl
      ["https://static-cdn.jtvnw.net/s3_vods/bebc8cba2926d1967418_chewiemelodies_27786761696_805342775/thumb/thumb0-%{width}x%{height}.jpg"]
  , test "viewable" <| \_ ->
    decodes viewable
      [Public]
  , test "view count" <| \_ ->
    decodes viewCount
      [142]
  , test "language" <| \_ ->
    decodes language
      ["en"]
  , test "videoType" <| \_ ->
    decodes videoType
      [Archive]
  , test "duration" <| \_ ->
    decodes duration
      [11313000]
  ]

decodes : Json.Decode.Decoder a -> (List a) -> Expectation
decodes decoder expectation =
  Expect.equal
    (Json.Decode.decodeString (response decoder) sampleVideo)
    (Ok expectation)
