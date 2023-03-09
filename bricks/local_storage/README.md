# Repository

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A brick to create a flutter storage repository with shared_preferences, flutter_secure_storage and riverpod

## Prerequisites

- [hooks_riverpod](https://pub.dev/packages/hooks_riverpod)
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
                ├── local_storage_repository.dart
```

```dart
// local_storage_repository.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localStorageProvider = Provider<LocalStorageRepository>(
      (_) => LocalStorageRepositoryImpl(
    const FlutterSecureStorage(),
    SharedPreferences.getInstance(),
  ),
);

abstract class LocalStorageRepository {
  Future<void> deleteAll();
}

class LocalStorageRepositoryImpl implements LocalStorageRepository {
  final FlutterSecureStorage _secureStorage;
  final Future<SharedPreferences> _sharedPreferencesFuture;
  SharedPreferences? _sharedPreferencesInstance;

  LocalStorageRepositoryImpl(
      this._secureStorage,
      this._sharedPreferencesFuture,
      ) {
    _clearSecureStorageOnReinstall();
  }

  Future<SharedPreferences> get _sharedPrefs async {
    return _sharedPreferencesInstance ??= await _sharedPreferencesFuture;
  }

  @override
  Future<void> deleteAll() async {
    await Future.wait([
      _deleteAllSharedPrefs(),
      _deleteAllSecure(),
    ]);
  }

  Future<T?> _read<T>(LocalStorageKey key) async =>
      (await _sharedPrefs).get(key.key) as T?;

  Future<String?> _readSecure(LocalStorageKey key) async =>
      _secureStorage.read(key: key.key);

  Future<void> _write({
    required LocalStorageKey key,
    required String value,
  }) async {
    (await _sharedPrefs).setString(key.key, value);
  }

  Future<void> _writeSecure({
    required LocalStorageKey key,
    required String value,
  }) async {
    await _secureStorage.write(key: key.key, value: value);
  }

  Future<void> _deleteAllSharedPrefs() async => (await _sharedPrefs).clear();

  Future<void> _deleteAllSecure() async => await _secureStorage.deleteAll();

  ///Necessary because of https://github.com/mogol/flutter_secure_storage/issues/88
  Future<void> _clearSecureStorageOnReinstall() async {
    const key = 'hasRunBefore';
    final sharedPreferences = await _sharedPrefs;
    if (sharedPreferences.getBool(key) != true) {
      await _deleteAllSecure();
      await sharedPreferences.setBool(key, true);
    }
  }
}

enum LocalStorageKey {
  token('token');

  final String key;
  const LocalStorageKey(this.key);
}
```