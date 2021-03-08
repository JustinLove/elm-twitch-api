module ParserTest exposing(..)

import Twitch.Parse exposing (..)

import Parser.Advanced as Parser exposing ((|.))

import Expect exposing (Expectation)
import Test exposing (..)

suite : Test
suite = describe "parsering"
  [ describe "builtin functions"
    [ test "int" <| \_ ->
      Expect.equal (Ok 11) (Parser.run parserInt "11")
    , test "does handle suffixed int" <| \_ ->
      case (Parser.run parserInt "11h22m33s") of
        Err err -> let _ = Debug.log "err" err in Expect.fail "parse error"
        Ok i -> Expect.equal 11 i
    , test "does not handle leading 0" <| \_ ->
      case (Parser.run parserInt "02m3s") of
        Err err -> let _ = Debug.log "err" err in Expect.fail "parse error"
        Ok i -> Expect.equal 0 i -- we want 2
    ]
  , describe "custom functions"
    [ test "int" <| \_ ->
      Expect.equal (Ok 11) (Parser.run int "11")
    , test "suffixed int" <| \_ ->
      Expect.equal (Ok 11) (Parser.run int "11h")
    , test "suffixed int and suffix" <| \_ ->
      Expect.equal (Ok 11) (Parser.run (int |. Parser.symbol (Parser.Token "h" "")) "11h")
    , test "3 element duration" <| \_ ->
      Expect.equal
        (Ok ((60 * 60 * 11 + 60 * 2 + 3) * 1000))
        (Parser.run (duration) "11h02m3s")
    , test "2 element duration" <| \_ ->
      Expect.equal
        (Ok ((60 * 60 * 0 + 60 * 2 + 3) * 1000))
        (Parser.run (duration) "02m3s")
    , test "1 element duration" <| \_ ->
      Expect.equal
        (Ok ((60 * 60 * 0 + 60 * 0 + 3) * 1000))
        (Parser.run (duration) "3s")
    , test "ignores trailing unknown chracter" <| \_ ->
      Parser.run duration "3x"
        |> Expect.err
    , test "ignores valid chracter with no numbers" <| \_ ->
      Parser.run duration "s"
        |> Expect.err
    , test "ignores missing minutes" <| \_ ->
      Parser.run duration "3h39s"
        |> Expect.err
    ]
  ]

parserInt = Parser.int "expecting int" "invalid number"
