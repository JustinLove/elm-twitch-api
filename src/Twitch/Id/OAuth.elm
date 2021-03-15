module Twitch.Id.OAuth exposing
  ( accessToken
  , expiresIn
  , scope
  , tokenType
  , sampleAppOAuth
  , sampleClientOAuth
  )

import Json.Decode exposing (..)
import Time exposing (Posix)

accessToken : Decoder String
accessToken = (field "access_token" string)

expiresIn : Decoder Int
expiresIn = (field "expires_in" int)

scope : Decoder (List String)
scope = (oneOf
    [ (field "scope" (list string))
    , (succeed [])
    ]
  )

tokenType : Decoder String
tokenType = (field "token_type" string)

{-| Sample data for App OAuth access token
-}
sampleAppOAuth : String
sampleAppOAuth = """
{
  "access_token": "0123456789abcdefghijABCDEFGHIJ",
  "refresh_token": "eyJfaWQmNzMtNGCJ9%6VFV5LNrZFUj8oU231/3Aj",
  "expires_in": 3600,
  "scope": ["viewing_activity_read"],
  "token_type": "bearer"
}
"""

{-| Sample data for Client OAuth access token
-}
sampleClientOAuth : String
sampleClientOAuth = """
{
  "access_token": "prau3ol6mg5glgek8m89ec2s9q5i3i",
  "expires_in": 3600,
  "token_type": "bearer"
}
"""
