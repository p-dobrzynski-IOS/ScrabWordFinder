# ScrabWordFinder

[![Build Status](https://travis-ci.com/p-dobrzynski-IOS/ScrabWordFinder.svg?branch=master)](https://travis-ci.com/p-dobrzynski-IOS/ScrabWordFinder)

<img src="/images/letter_made_icon.png" width="75"/>

Hello there! This is **ScrabWordFinder**, iOS app for finding words from given letters.

## Screens

<img src="/images/ScrabWordFinder_01.png" width="250"/> <img src="/images/ScrabWordFinder_02.png" width="250"/> <img src="/images/ScrabWordFinder_03.png" width="250"/>


## Info

This iOS app was created to find validated words from given letters. Words generated from letters are compared to a list of possible words. Validated words are returned and presented in table.

Application is based on **UINavigationController**. It also inludes some custom UI Elements such as custom **UITexfield** with dropping letters effect. 

<img src="/gifs/letters_drop.gif" width="250"/>


Project also use [SpriteKit](https://developer.apple.com/spritekit/) iOS framework, which allow to free fall of prepared sprites *(Main Screen)*. The effect also uses **gyro** readings that allow you to change the gravity of the GameScene.

<img src="/gifs/shake_screen.gif" width="250"/>

The application also contains **Unit tests** thanks to which it is possible to maintain the continuity of the application's operation.


## Used Tools

### Swiftlint

A tool to enforce Swift style and conventions, loosely based on GitHub's Swift Style Guide.

Link: [Swiftlint](https://github.com/realm/SwiftLint) 

### Jenkins CI

All repo pull request are validated by Jenkins CI. As an extensible automation server, Jenkins can be used as a simple CI server or turned into the continuous delivery hub for any project.

Link: [Jenkins CI](https://www.jenkins.io/)

## Used Pods

### Snapkit

Interface is created programmatically by usiing [SnapKit](https://github.com/SnapKit/SnapKit) package. Which allow building constraints allows building constraints with minimal amounts of code while ensuring they are easy to read and understand.

Link: [Snapkit](https://www.google.com)

### Lottie iOS

Project use JSON based animations with [Lottie-ios](https://github.com/airbnb/lottie-ios) tool. Lottie is a mobile library for Android and iOS that natively renders vector based animations and art in realtime with minimal code.

Link: [Lottie-ios](https://github.com/airbnb/lottie-ios)

## TODO 
 * Validate words by using dictionary API
 * Add more Unit Test
 * Ability to validate words in languages ​​other than English.
