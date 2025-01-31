import 'dart:io';

import 'package:dio/dio.dart';
import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/core/token/token_local_datasource.dart';

import '../../domain/remote_datasource/quiz_teacher_detail_form_question_remote_datasource.dart';

class QuizTeacherDetailFormQuestionRemoteDatasourceImpl implements QuizTeacherDetailFormQuestionRemoteDatasource {
  final DioClient _dioClient;
  final TokenLocalDatasource _tokenLocalDatasource;
  QuizTeacherDetailFormQuestionRemoteDatasourceImpl(
    this._dioClient,
    this._tokenLocalDatasource,
  );

  @override
  Future<String> createQuestion({required String questionName, File? imageFile}) async {
    final token = await _tokenLocalDatasource.getToken();
    final data = FormData.fromMap({
      'question': questionName,
      if (imageFile != null)
        'quiz_image_path': await MultipartFile.fromFile(
          imageFile.path,
          filename: 'question_images',
        )
    });
    final request = await _dioClient.post(
      '/api/create-question',
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final String response = request.data['message'];
    return response;
  }
}
