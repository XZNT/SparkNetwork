# agora-token-builder

(Unofficial) Token builder for agora.io

| Product                  | Versions that support tokens                                                                                |
|--------------------------|-------------------------------------------------------------------------------------------------------------|
| RTC SDK                  | * The Native SDK: v2.1.0 or later * The Web SDK: v2.4.0 or later * Third-party framework SDKs: All versions |
| On-premise Recording SDK | v2.1.0 or later                                                                                             |
| Cloud Recording          | No version requirement                                                                                      |
| Interactive Gaming SDK   | v2.2.0 or later                                                                                             |

## Insall

```bash
composer require taylanunutmaz/agora-token-builder
```

## Usage


### RTC Token

#### Token with int uid

```php
$token = RtcTokenBuilder::buildTokenWithUid($appID, $appCertificate, $channelName, $uid, $role, $privilegeExpiredTs);
```

#### Token with user account

```php
$token = RtcTokenBuilder::buildTokenWithUserAccount($appID, $appCertificate, $channelName, $uidStr, $role, $privilegeExpiredTs);
``

### RTM Token

```php
$token = RtmTokenBuilder::buildToken($appID, $appCertificate, $user, $role, $privilegeExpiredTs);
```

## API Reference

| Parameter           | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|---------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| $appID              | The App ID of your Agora project                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| $appCertificate     | The App Certificate of your Agora project.                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| $channelName        | The unique channel name for the Agora RTC session in the string format. The string length must be less than 64 bytes. Supported character scopes are:  * All lowercase English letters: a to z. * All uppercase English letters: A to Z. * All numeric characters: 0 to 9. * The space character. * Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ",". |
| $uid                | The user ID. A 32-bit unsigned integer with a value range from 1 to (2^32 - 1). It must be unique. Set ``uid`` as 0, if you do not want to authenticate the user ID, that is, any uid from the app client can join the channel or log onto the service system.                                                                                                                                                                                                                               |
| $uidStr             | The username of user. This value must be string.                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| $role               | The privilege of the user:  * ``Role_Publisher``(1): (Default) The user has the privilege of publishing streams. * ``Role_Subscriber``(2): The user does not have the privilege of publishing streams.                                                                                                                                                                                                                                                                                       |
| $privilegeExpiredTs | The Unix timestamp (s) when the token expires, represented by the sum of the current timestamp and the valid time of the token. For example, if you set ``privilegeExpiredTs`` as the current timestamp plus 600 seconds, the token expires in 10 minutes. A token is valid for 24 hours at most. If you set this parameter as 0 or a period longer than 24 hours, the token is valid for 24 hours.                                                                                          |

## LICENSE
MIT
