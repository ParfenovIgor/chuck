# Tinder with Chuck Norris

![Screenshot](./assets/images/chuck_orange.png)

Flutter project for course [F22] CPMDWithF.

## Author

Igor Parfenov

Contact: [@Igor_Parfenov](https://t.me/Igor_Parfenov)

## Overview

There are five screens:

* `Menu` - contains buttons opening other screens
* `Random Jokes` - loads random jokes.
* `Saved Jokes` - loads locally saved jokes.
* `Search Jokes` - contains two pages, the first one asks text input, the other shows result of search the specified input.
* `Jokes Categories` - contains two pages, the first one loads categories (a.k.a. tags), the other shows random jokes with specified category.

Each screen contains six buttons:

* `Like`
* `Dislike`
* `Open in browser`
* `Copy text to clipboard`
* `Save the joke` for all screens except `Saved Jokes`, and `Delete the joke` for screen `Saved Jokes`
* `Back`

## Instruments

* For storage `Hive` was used
* For dependence management `Riverpod` was used (however, the only thing it does is changing theme)
* `Firebase Crashlytics` was used
* Custom error widget was written

## Screenshot

![Screenshot](./screenshots/screenshot01.jpg)

[More Screenshots](./screenshots/README.md)

## Build

App build for Android: [apk](./build/app/outputs/apk/release/app-release.apk)
