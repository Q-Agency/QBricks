# firebase_messaging

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A brick to add firebase_messaging feature to your project

## Prerequisites

Installed version of [hooks_riverpod](https://pub.dev/packages/hooks_riverpod)

## How to use 🚀

```
mason make firebase_messaging --project_name app
```

## Variables ✨

| Variable         | Description                      | Default         | Type      |
| ---------------- | -------------------------------- | --------------- | --------- |
| `project_name`   | The name of the project          | app             | `string`  |

## Steps to finish setup
### Android
To finish Android setup 
- create Android app on Firebase console
- generate keystore fingerprints and store them in Firebase console for your app
- add google-services.json to android/app/ directory
- add "classpath 'com.google.gms:google-services:<latest_version>'" to android/build.gradle file
- add "apply plugin: 'com.google.gms.google-services'" to android/app/build.gradle file

### iOS
To finish iOS setup
- create iOS app on Firebase console
- add auth key or push notification certificate from developer.apple.com to it
- add PushNotification capability in Xcode (ios/Runner/Runner.entitlements file) 
- add GoogleService-Info.plist file to ios/Runner directory

### Flutter
- add firebase_messaging dependency to your project's pubspec.yaml and add 
`await Firebase.initializeApp()` in main.dart
- add `ref.firebaseMessagingNotificationListener();` in the widget where you want to listen for 
push notifications
