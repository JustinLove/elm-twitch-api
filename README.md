# Elm Twitch Api

Decoders and a few other helpers for using [Twitch.tv APIs](https://dev.twitch.tv/docs/api/).

Partial coverage of the APIs I have used.

- Includes most the Helix (new Twitch API).
- Some Kraken decoders where equivalent was not available at the time
- Some additional decoders for unofficial hosts and clips APIS.

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

- https://github.com/JustinLove/following_videos ([Following Videos](https://wondible.com/following_videos/))
- https://github.com/JustinLove/hostable ([Hostable](https://wondible.com/hostable/))
- https://github.com/JustinLove/hosting-clips ([Hosting Clips](https://wondible.com/hosting-clips/))
- https://github.com/JustinLove/schedule-from-videos ([Schedule From Videos](https://wondible.com/schedule-from-videos/))
- https://github.com/JustinLove/stream-credits ([Stream Credits](https://wondible.com/stream-credits/))
