module Twitch.Id.OAuth exposing
  ( accessToken
  , refreshToken
  , expiresIn
  , scope
  , tokenType
  , sampleAppOAuth
  , sampleClientOAuth
  )

{-| JSON Decoders for Twitch OAuth 

Use these pieces to pull out the parts your application needs.

    import Twitch.Id.OAuth as OAuth
    import Json.Decode as Decode

    decodeToken : Decode.Decoder Secret
    decodeToken =
      OAuth.accessToken
        |> Decode.map Secret.fromString

# Field decoders
@docs accessToken, refreshToken, expiresIn, scope, tokenType

# Sample Data
@docs sampleAppOAuth, sampleClientOAuth
-}


import Json.Decode exposing (..)
import Time exposing (Posix)

{-| Access token for api requests
-}
accessToken : Decoder String
accessToken = (field "access_token" string)

{-| Refresh token for app oauth
-}
refreshToken : Decoder String
refreshToken = (field "refresh_token" string)

{-| Expire time in seconds
-}
expiresIn : Decoder Int
expiresIn = (field "expires_in" int)

{-| Scopes (permissions) provided by the token
-}
scope : Decoder (List String)
scope = (oneOf
    [ (field "scope" (list string))
    , (succeed [])
    ]
  )

{-| Type of the accessToken
-}
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
