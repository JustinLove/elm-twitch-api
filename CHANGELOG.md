## Elm Twitch API

## 6.0.0

- Helix will require oauth login starting on 2020-04-30. The Helix.send auth parameter is no longer a Maybe, and the authHeaders function is no longer provided seperately.
- The ClipsV2 module has been removed. The API is responding with 410 Gone.

## 5.0.1

- Twitch is supplying nulls in stream `tag_ids`. They are translated to empty arrays.

## 5.0.0

- Remove Kraken/V5 support. This is on depreciation track and all package features are removed or available in Helix.
- Community ids removed from streams response, breaking previous decoder versions.
- Added userName and tagIds to streams response

## 4.3.0

- Add Helix Subscriptions

## 4.2.0

- The unofficial TMI hosts api stopped returning target name information for target= queries. Added new HostingTarget and hostingTarget type and decoder to correctly parse these responses.

## 4.1.1

- Fix syntax for Kraken auth token header

## 4.1.0

- Add Helix Bits Leaderboard and Kraken Subscriptions

## 4.0.0

- Add missing fields to Follow type, and renormalize it's existing field names

## 3.0.1

- Update to http 2.0

## 3.0.0

- Elm 0.19
  - Time.Time fields have become Time.Posix or Int (duration) as appropriate

## 2.0.0

- Add missing fields to Helix stream type and decoder
- Add request helper for Kraken/V5 API
- Add Kraken/V5 Community structure and decoder
