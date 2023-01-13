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
  Future<void> write({
    required LocalStorageKey key,
    required String value,
  });

  Future<void> writeSecure({
    required LocalStorageKey key,
    required String value,
  });

  Future<T?> read<T>(LocalStorageKey key);

  Future<String?> readSecure(LocalStorageKey key);

  Future<void> delete(LocalStorageKey key);

  Future<void> deleteSecure(LocalStorageKey key);

  Future<void> deleteAllSharedPrefs();

  Future<void> deleteAllSecure();

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
    clearSecureStorageOnReinstall();
  }

  Future<SharedPreferences> get _sharedPrefs async {
    return _sharedPreferencesInstance ??= await _sharedPreferencesFuture;
  }

  @override
  Future<void> write({
    required LocalStorageKey key,
    required String value,
  }) async {
    (await _sharedPrefs).setString(key.key, value);
  }

  @override
  Future<void> writeSecure({
    required LocalStorageKey key,
    required String value,
  }) async {
    await _secureStorage.write(key: key.key, value: value);
  }

  @override
  Future<T?> read<T>(LocalStorageKey key) async =>
      (await _sharedPrefs).get(key.key) as T?;

  @override
  Future<String?> readSecure(LocalStorageKey key) async =>
      _secureStorage.read(key: key.key);

  @override
  Future<void> delete(LocalStorageKey key) async =>
      (await _sharedPrefs).remove(key.key);

  @override
  Future<void> deleteSecure(LocalStorageKey key) async =>
      await _secureStorage.delete(key: key.key);

  @override
  Future<void> deleteAllSharedPrefs() async => (await _sharedPrefs).clear();

  @override
  Future<void> deleteAllSecure() async => await _secureStorage.deleteAll();

  @override
  Future<void> deleteAll() async {
    await Future.wait([
      deleteAllSharedPrefs(),
      deleteAllSecure(),
    ]);
  }

  ///Necessary because of https://github.com/mogol/flutter_secure_storage/issues/88
  Future<void> clearSecureStorageOnReinstall() async {
    const key = 'hasRunBefore';
    final sharedPreferences = await _sharedPrefs;
    if (sharedPreferences.getBool(key) != true) {
      await deleteAllSecure();
      await sharedPreferences.setBool(key, true);
    }
  }
}

enum LocalStorageKey {
  token('token'),
  password('password');

  final String key;
  const LocalStorageKey(this.key);
}
