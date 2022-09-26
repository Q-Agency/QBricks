# local_auth

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A brick to add local_auth feature to your project

## Prerequisites

- [hooks_riverpod](https://pub.dev/packages/hooks_riverpod)
- [local_auth](https://pub.dev/packages/local_auth)

## How to use 🚀

```
mason make connectivity --project_name app
```

## Variables ✨

| Variable       | Description             | Default | Type     |
|----------------|-------------------------|---------|----------|
| `project_name` | The name of the project | app     | `string` |

## Outputs 📦

```
mason make local_auth --project_name app
├── features
      ├── local_auth
          ├── data
                ├── repositories
                      ├── local_auth_repository.dart
```

## Steps to finish setup
### Android
- add permission to your AndroidManifest.xml file `<uses-permission android:name="android.permission.USE_BIOMETRIC"/>`
- change that MainActivity (whether Java or Kotlin) extends FlutterFragmentActivity instead of FlutterActivity
- then change res/values/styles.xml that style's parent is `"@style/Theme.AppCompat.Light.NoActionBar"` 
- instead of `"@android:style/Theme.Light.NoTitleBar"`

### iOS
- add permission to Info.plist file to use Face ID
```
<key>NSFaceIDUsageDescription</key>
<string>Text with explanation why you need to use Face ID></string>
```


