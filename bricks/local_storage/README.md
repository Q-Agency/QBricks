# local_storage

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A brick to create a flutter storage service with shared_preferences and
flutter_secure_storage

## Prerequisites

- [shared_preferences](https://pub.dev/packages/shared_preferences)
- [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)

## How to use 🚀

```
mason make local_storage
```

## Outputs 📦

```
mason make local_storage
├── lib
      ├── common
          ├── data
                ├── services
                    ├── local_storage_service.dart
```

## Steps to finish setup

- register your LocalStorageService class with GetIt's registerSingleton()
  method into your service locator
