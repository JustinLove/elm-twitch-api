module Twitch.Parse exposing (duration, int)

import Parser.Advanced exposing (..)
import Char

type alias ContextParser a = Parser String String a

duration : ContextParser Int
duration =
  inContext "parsing a duration" <|
    succeed (\i f -> (f i) * 1000)
      |= int
      |= oneOf
        [ hxxmxxs
        , mxxs
        , s
        ]

hxxmxxs : ContextParser (Int -> Int)
hxxmxxs =
  inContext "Trying hours-minutes-seconds duration" <|
    succeed (\m s_ h -> h*60*60 + m*60 + s_)
      |. symbol (Token "h" "Looking for 'h'")
      |= int
      |. symbol (Token "m" "Expecting 'm'")
      |= int
      |. symbol (Token "s" "Final 's'")

mxxs : ContextParser (Int -> Int)
mxxs =
  inContext "Trying minutes-seconds duration" <|
    succeed (\s_ m -> m*60 + s_)
      |. symbol (Token "m" "Looking for 'm'")
      |= int
      |. symbol (Token "s" "Final 's'")

s : ContextParser (Int -> Int)
s =
  inContext "Trying seconds only duration" <|
    succeed (\s_ -> s_)
      |. symbol (Token "s" "Looking for 's'")

int : ContextParser Int
int =
  inContext "parsing int" <|
    (getChompedString (chompWhile Char.isDigit)
      |> andThen (\str -> case String.toInt str of
        Just i -> succeed i
        Nothing -> problem ("String.toInt failed on (" ++ str ++ ")")
      )
    )

