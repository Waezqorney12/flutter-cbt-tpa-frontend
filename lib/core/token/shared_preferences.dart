import 'package:shared_preferences/shared_preferences.dart';

typedef X = String;
typedef T = Future<bool>;

abstract interface class SharedPreferencesInterface {
  Future<String?> readString(X key);

  Future<bool?> readBool(X key);

  Future<int?> readInt(X key);

  Future<T> addString(X key, X value);

  Future<T> addBool(X key, bool value);

  Future<T> addInt(X key, int value);

  Future<bool> remove(X key);

  Future<bool> reset();
}

class SharedPreferencesImpl implements SharedPreferencesInterface {
  final SharedPreferences _sharedPreferences;
  const SharedPreferencesImpl(this._sharedPreferences);

  @override
  Future<bool?> readBool(X key) async {
    return _sharedPreferences.getBool(key);
  }

  @override
  Future<int?> readInt(X key) async {
    return _sharedPreferences.getInt(key);
  }

  @override
  Future<String?> readString(X key) async {
    return _sharedPreferences.getString(key);
  }

  @override
  Future<bool> remove(X key) => _sharedPreferences.remove(key);

  @override
  Future<bool> reset() => _sharedPreferences.clear();

  @override
  Future<T> addString(X key, X value) async {
    return _sharedPreferences.setString(key, value);
  }

  @override
  Future<T> addBool(X key, bool value) async {
    return _sharedPreferences.setBool(key, value);
  }

  @override
  Future<T> addInt(X key, int value) async {
    return _sharedPreferences.setInt(key, value);
  }
}
