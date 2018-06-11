# Elm Twitch Api

Decoders and a few other helpers for using Twitch.tv APIs.

Partial coverage of the APIs I have used, includes most the Helix (new Twitch API) and some additional decoders for unoffical hosts and clips APIS.)

    fetchUserByNameUrl : String -> String
    fetchUserByNameUrl login =
      "https://api.twitch.tv/helix/users?login=" ++ login

    fetchUserByName : String -> Cmd Msg
    fetchUserByName login =
      Twitch.Helix.send <|
        { clientId = TwitchId.clientId
        , auth = Nothing
        , decoder = Twitch.Helix.Decode.users
        , tagger = User
        , url = (fetchUserByNameUrl login)
        }

## Example applications using this library:

- https://github.com/JustinLove/following_videos
- https://github.com/JustinLove/hostable
- https://github.com/JustinLove/hosting-clips
- https://github.com/JustinLove/schedule-from-videos
