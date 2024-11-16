import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/core/message/server_exception.dart';
import 'package:test_potensial/core/model/user_model.dart';
import 'package:test_potensial/core/token/token_local_datasource.dart';
import 'package:test_potensial/core/utils/log.dart';

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
    String? firstName,
    String? lastName,
    String? email,
    File? image,
  ) async {
    try {
      final String? token = await _tokenLocalDatasource.getToken();
      final userdata = FormData.fromMap({
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phone,
        if (image != null) 'image': await MultipartFile.fromFile(image.path, filename: 'profile_images.jpg'),
      });
      final request = await _dio.post(
        '/api/change-profile',
        data: userdata,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      Log.loggerInformation('Change Profile: ${request.data}');

      final UserModel updateUser = UserModel.fromJson(request.data['data']);
      // _tokenLocalDatasource.updateUserData(updateUser);
      return updateUser;
    } catch (e) {
      throw ServerException(message: 'Server Error: $e');
    }
  }
}
