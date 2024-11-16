import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/core/model/user_model.dart';

import '../../../../core/message/server_exception.dart';
import '../../domain/datasource/forgot_password_remote_datasource.dart';

final class ForgotPasswordRemoteDataSourceImpl implements ForgotPasswordRemoteDataSource {
  final DioClient _dio;

  ForgotPasswordRemoteDataSourceImpl(this._dio);

  @override
  Future<String> sendEmail({required String email}) async {
    try {
      final response = await _dio.post(
        '/api/send-otp',
        data: UserModel(email: email).toJson(),
      );
      return response.data['data'];
    } catch (e) {
      throw ServerException(message: 'Terjadi kesalahan pada server: $e');
    }
  }

  @override
  Future<String> verifyCode({required String code}) async {
    try {
      final response = await _dio.post(
        '/api/reset-password',
        data: {
          'otp': code,
        },
      );
      return response.data['data'];
    } catch (e) {
      throw ServerException(message: 'Terjadi kesalahan pada server: $e');
    }
  }
}
