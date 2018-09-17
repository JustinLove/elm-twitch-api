import Twitch.Parse exposing (..)

import Expectation exposing (eql, isTrue, isFalse)
import Test exposing (it, describe, Test)
import Runner exposing (runAll)

import Html exposing (Html)
import Parser.Advanced as Parser exposing ((|.))

main : Html msg
main =
  runAll all

all : Test
all = describe "parsering"
  [ describe "builtin functions"
    [ it "int" <|
      eql (Ok 11) (Parser.run parserInt "11")
    , it "does handle suffixed int" <|
      case (Parser.run parserInt "11h22m33s") of
        Err err -> let _ = Debug.log "err" err in isTrue False
        Ok i -> eql 11 i
    , it "does not handle leading 0" <|
      case (Parser.run parserInt "02m3s") of
        Err err -> let _ = Debug.log "err" err in isTrue False
        Ok i -> eql 0 i -- we want 2
    ]
  , describe "custom functions"
    [ it "int" <|
      eql (Ok 11) (Parser.run int "11")
    , it "suffixed int" <|
      eql (Ok 11) (Parser.run int "11h")
    , it "suffixed int and suffix" <|
      eql (Ok 11) (Parser.run (int |. Parser.symbol (Parser.Token "h" "")) "11h")
    , it "3 element duration" <|
      eql
        (Ok ((60 * 60 * 11 + 60 * 2 + 3) * 1000))
        (Parser.run (duration) "11h02m3s")
    , it "2 element duration" <|
      eql
        (Ok ((60 * 60 * 0 + 60 * 2 + 3) * 1000))
        (Parser.run (duration) "02m3s")
    , it "1 element duration" <|
      eql
        (Ok ((60 * 60 * 0 + 60 * 0 + 3) * 1000))
        (Parser.run (duration) "3s")
    , it "ignores invalid input" <|
      case (Parser.run duration "3x") of
        Err err -> let _ = Debug.log "err" err in isTrue True
        Ok _ -> isTrue False
    , it "ignores invalid input" <|
      case (Parser.run duration "s") of
        Err err -> let _ = Debug.log "err" err in isTrue True
        Ok _ -> isTrue False
    , it "ignores invalid input" <|
      case (Parser.run duration "3h39s") of
        Err err -> let _ = Debug.log "err" err in isTrue True
        Ok _ -> isTrue False
    ]
  ]

parserInt = Parser.int "expecting int" "invalid number"
