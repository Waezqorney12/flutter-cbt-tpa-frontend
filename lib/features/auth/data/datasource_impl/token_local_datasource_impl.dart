import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/datasource/token_local_datasource.dart';

class TokenLocalDatasourceImpl implements TokenLocalDatasource {
  final SharedPreferences _sharedPreferences;
  const TokenLocalDatasourceImpl(this._sharedPreferences);

  @override
  Future<void> saveToken(String token) async => await _sharedPreferences.setString('access_token', token);
}
