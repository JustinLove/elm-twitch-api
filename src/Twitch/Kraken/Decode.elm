module Twitch.Kraken.Decode exposing
  ( Community
  , community
  , sampleCommunity
  )

{-| Decoders for the Kraken API.

# Users
@docs Community, community

# Sample data
@docs sampleCommunity
-}

import Json.Decode exposing (..)

-------- Community -------


{-| Record for decoded community.
-}
type alias Community =
  { id : String
  , avatarImageUrl : String
  , coverImageUrl : String
  , description : String
  , descriptionHtml : String
  , language : String
  , name : String
  , ownerId : String
  , rules : String
  , summary : String
  }

{-| Json Decoder for a community
-}
community : Decoder Community
community =
  succeed Community
    |> map2 (|>) (field "_id" string)
    |> map2 (|>) (field "avatar_image_url" string)
    |> map2 (|>) (field "cover_image_url" string)
    |> map2 (|>) (field "description" string)
    |> map2 (|>) (field "description_html" string)
    |> map2 (|>) (field "language" string)
    |> map2 (|>) (field "name" string)
    |> map2 (|>) (field "owner_id" string)
    |> map2 (|>) (field "rules" string)
    |> map2 (|>) (field "summary" string)


{-| Sample data for a community.
-}
sampleCommunity : String
sampleCommunity = """
{
   "_id": "e9f17055-810f-4736-ba40-fba4ac541caa",
   "avatar_image_url": "",
   "cover_image_url": "",
   "description": "# A Dedicated Tester Community.",
   "description_html": "<h3>A Dedicated Tester Community.</h3>\n",
   "language": "EN",
   "name": "DallasTesterCommunity",
   "owner_id": "44322889",
   "rules": "1. Follow the Twitch Rules of Conduct to the letter. 2. Be kind! 3. Respect other humans. 4. Include everyone.",
   "rules_html": "<ol>\n<li>Follow the Twitch Rules of Conduct to the letter. 2. Be kind! 3. Respect other humans. 4. Include everyone.<br></li>\n</ol>\n",
   "summary": "A community for Dallas Tester or a tester community in Dallas?"
}
"""
