module Twitch.Parse exposing (duration, int)

import Parser exposing (..)
--import Parser.Advanced exposing (inContext)
import Char

duration : Parser Int
duration =
  succeed (\h m s -> (60 * 60 * h + 60 * m + s) * 1000)
    |= (suffixedInt "h" |> withDefault 0)
    |= (suffixedInt "m" |> withDefault 0)
    |= (suffixedInt "s")
    |. end

withDefault : a -> Parser a -> Parser a
withDefault default parser =
  oneOf
    [ parser
    , succeed default
    ]

suffixedInt : String -> Parser Int
suffixedInt suffix =
  --inContext ("int suffixed with " ++ suffix) <|
    succeed (\i -> i)
      |= int
      |. (symbol suffix)

int : Parser Int
int =
  --inContext "int" <|
    (getChompedString (chompWhile Char.isDigit)
      |> andThen (\s -> case String.toInt s of
        Just i -> succeed i
        Nothing -> problem ("String.toInt failed on " ++ s)
      )
    )

