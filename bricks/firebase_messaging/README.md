# firebase_messaging

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A brick to add firebase_messaging feature to your project

## Prerequisites

- [firebase_messaging](https://pub.dev/packages/firebase_messaging)
- [loggy](https://pub.dev/packages/loggy)
- [equatable](https://pub.dev/packages/equatable)
- [build_runner](https://pub.dev/packages/build_runner)
- [json_serializable](https://pub.dev/packages/json_serializable)
- [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications)
  if `system_foreground_notifications` set to `true`

## How to use 🚀

```
mason make firebase_messaging --project_name app
```

## Variables ✨

| Variable                          | Description                                                                                                                         | Default | Type      |
| --------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- | ------- | --------- |
| `project_name`                    | The name of the project                                                                                                             | app     | `string`  |
| `system_foreground_notifications` | If you want to show system push notifications while the app is in foreground, `flutter_local_notifications` is required for Android | app     | `boolean` |

## Outputs 📦

```
mason make firebase_messaging --project_name app
├── features
      ├── firebase_messaging
          ├── data
                ├── repositories
                      ├── firebase_messaging_repository.dart
          ├── domain
                ├── entities
                      ├── firebase_messaging_notification.dart
                ├── notifiers
                      ├── firebase_messaging_notifier.dart
```

## Steps to finish setup

### Android

To finish Android setup

- create Android app on Firebase console
- generate keystore fingerprints and store them in Firebase console for your app
- add google-services.json to android/app/ directory
- add "id("com.google.gms.google-services") version "<latest_version>" apply
  false:'" to settings.gradle.kts file
- add "id("com.google.gms.google-services")" to plugins block in
  android/app/build.gradle.kts file
- about push notification icon:
  - to make sure that notification icon is displayed properly on all Android
    devices and OS versions, add png icon with transparent background (or with
    solid background but transparent logo) to `res/drawable` folder (to find out
    more: https://stackoverflow.com/a/45318726)
  - link icon from `res/drawable` in your manifest file (more info here
    https://firebase.google.com/docs/cloud-messaging/android/client#manifest)
  ```
  <!-- Set custom default icon. This is used when no icon is set for incoming notification messages.
     See README(https://goo.gl/l4GJaQ) for more. -->
  <meta-data
    android:name="com.google.firebase.messaging.default_notification_icon"
    android:resource="@drawable/your_notification_icon" />
  ```
  and you can also define color for your icon:
  ```
  <!-- Set color used with incoming notification messages. This is used when no color is set for the incoming
     notification message. See README(https://goo.gl/6BKBk7) for more. -->
  <meta-data
    android:name="com.google.firebase.messaging.default_notification_color"
    android:resource="@color/colorAccent" />
  ```

### iOS

To finish iOS setup

- create iOS app on Firebase console
- add auth key or push notification certificate from developer.apple.com to it
- add PushNotification capability in Xcode (ios/Runner/Runner.entitlements file)
- add GoogleService-Info.plist file to ios/Runner directory

### Flutter

- add `await Firebase.initializeApp()` in main.dart
- register FirebaseMessagingRepository and FirebaseMessagingNotifier (with
  registerLazySingleton with dispose option) with GetIt into your service
  locator
- add QNotifierListener with FirebaseMessagingNotifier in the widget where you
  want to start listening for push notifications
