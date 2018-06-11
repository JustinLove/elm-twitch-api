module Twitch.Template exposing (imageTemplateUrl, imagePercentTemplateUrl)

{-| Helpers for filling in image and url templates received from API responses.

@docs imageTemplateUrl, imagePercentTemplateUrl
-}

{-| Fills in templates with {width} and {height}.

    Twitch.Template.imageTemplateUrl 168 95 stream.thumbnailUrl
-}
imageTemplateUrl : Int -> Int -> String -> String
imageTemplateUrl w h =
  String.split "{width}"
    >> String.join (toString w)
    >> String.split "{height}"
    >> String.join (toString h)

{-| Fills in templates with %{width} and %{height}.

    Twitch.Template.imagePercentTemplateUrl 320 180 video.thumbnailUrl
-}
imagePercentTemplateUrl : Int -> Int -> String -> String
imagePercentTemplateUrl w h =
  String.split "%{width}"
    >> String.join (toString w)
    >> String.split "%{height}"
    >> String.join (toString h)
