import 'package:test_potensial/core/infrastructure/network/dio_client.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_detail_form/data/model/quiz_question_model.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_detail_form/domain/remote_datasource/quiz_teacher_detail_form_remote_datasource.dart';

import '../../../../../core/message/server_exception.dart';

class QuizTeacherDetailFormRemoteDatasourceImpl implements QuizTeacherDetailFormRemoteDatasource {
  final DioClient _dioClient;
  const QuizTeacherDetailFormRemoteDatasourceImpl(
    this._dioClient,
  );

  @override
  Future<List<QuizQuestionModel>> getQuestion({String? name}) async {
    try {
      final isName = name != null ? '?name=$name' : '';
      final response = await _dioClient.get('/api/get-question$isName');
      final List<dynamic> data = response.data['data'];
      final List<QuizQuestionModel> dataToModel = data.map((value) => QuizQuestionModel.fromJson(value)).toList();
      return dataToModel;
    } catch (e) {
      throw ServerException(message: 'Terjadi kesalahan pada server: $e');
    }
  }
}
