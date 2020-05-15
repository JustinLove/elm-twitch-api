module Twitch.Id.Decode exposing
  ( AppOAuth
  , appOAuth
  , sampleAppOAuth
  )

{-| Decoders for the ID (oauth) API

# App OAuth (OAuth Client Credentials Flow)
@docs AppOAuth, appOAuth

# Sample data
@docs sampleAppOAuth

-}

import Json.Decode exposing (..)

--------- App OAuth ----------

{-| Record for App OAuth access tokens
-}
type alias AppOAuth =
  { accessToken : String
  , expiresIn : Int
  , scope : List String
  , tokenType : String
  }

{-| Decoder for App OAuth access token
-}
appOAuth : Decoder AppOAuth
appOAuth =
  succeed AppOAuth
    |> map2 (|>) (field "access_token" string)
    |> map2 (|>) (field "expires_in" int)
    |> map2 (|>) (oneOf
      [ (field "scope" (list string))
      , (succeed [])
      ]
      )
    |> map2 (|>) (field "token_type" string)

{-| Sample data for App OAuth access token
-}
sampleAppOAuth : String
sampleAppOAuth = """
{
  "access_token": "prau3ol6mg5glgek8m89ec2s9q5i3i",
  "expires_in": 3600,
  "scope": [],
  "token_type": "bearer"
}
"""
