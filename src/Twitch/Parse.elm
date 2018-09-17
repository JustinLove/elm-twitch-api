module Twitch.Parse exposing (duration, int)

import Parser exposing (..)
--import Parser.Advanced exposing (inContext)
import Char

duration : Parser Int
duration =
  succeed (\i f -> (f i) * 1000)
    |= int
    |= oneOf
      [ hxxmxxs
      , mxxs
      , s
      ]

hxxmxxs : Parser (Int -> Int)
hxxmxxs =
  succeed (\m s_ h -> h*60*60 + m*60 + s_)
    |. symbol "h"
    |= int
    |. symbol "m"
    |= int
    |. symbol "s"

mxxs : Parser (Int -> Int)
mxxs =
  succeed (\s_ m -> m*60 + s_)
    |. symbol "m"
    |= int
    |. symbol "s"

s : Parser (Int -> Int)
s =
  succeed (\s_ -> s_)
    |. symbol "s"

int : Parser Int
int =
  --inContext "int" <|
    (getChompedString (chompWhile Char.isDigit)
      |> andThen (\str -> case String.toInt str of
        Just i -> succeed i
        Nothing -> problem ("String.toInt failed on " ++ str)
      )
    )

