import 'package:dio/dio.dart';
import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/core/message/server_exception.dart';
import 'package:test_potensial/core/model/user_model.dart';
import 'package:test_potensial/core/token/token_local_datasource.dart';

import '../../domain/datasource/profile_detail_datasource.dart';

class ProfileDetailRemoteImplDatasource implements ProfileDetailDatasource {
  final DioClient _dio;
  final TokenLocalDatasource _tokenLocalDatasource;
  ProfileDetailRemoteImplDatasource(
    this._dio,
    this._tokenLocalDatasource,
  );

  @override
  Future<UserModel> changeProfile(
    String? phone,
    String? name,
    String? email,
    String? password,
  ) async {
    try {
      final String? token = await _tokenLocalDatasource.getToken();
      final request = await _dio.post(
        '/api/change',
        data: UserModel(
          email: email ?? '',
          name: name ?? '',
          password: password ?? '',
          phone: phone ?? '',
          roles: '',
        ).toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return UserModel.fromJson(request.data);
    } catch (e) {
      throw ServerException(message: 'Server Error: $e');
    }
  }
}
