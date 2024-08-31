import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class TokenLocalSecure {
  const TokenLocalSecure();

  Future<bool> hasData(String key);

  Future<String?> get(String key);

  Future<void> store(String key, String value);

  Future<void> remove(String key);

  Future<void> reset();
}

class TokenLocalSecureImpl extends TokenLocalSecure {
  final FlutterSecureStorage _storage;

  const TokenLocalSecureImpl(this._storage);

  @override
  Future<String?> get(String key) {
    return _storage.read(key: key);
  }

  @override
  Future<bool> hasData(String key) {
    return _storage.containsKey(key: key);
  }

  @override
  Future<void> remove(String key) {
    return _storage.delete(key: key);
  }

  @override
  Future<void> reset() {
    return _storage.deleteAll();
  }

  @override
  Future<void> store(String key, String value) {
    return _storage.write(key: key, value: value);
  }
}
