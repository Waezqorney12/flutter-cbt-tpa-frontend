import 'package:test_potensial/features/teacher/home_teacher/data/model/kelas_model.dart';

abstract class HomeTeacherRemoteDatasource {
  Future<List<ClassModel>> getClass();
  Future<String> createClass({
    required String className,
    String? classDescription,
  });
}
