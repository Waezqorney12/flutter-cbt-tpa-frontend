import 'package:test_potensial/core/utils/typedef_utils.dart';
import 'package:test_potensial/features/teacher/home_teacher/domain/entities/kelas_entities.dart';

abstract class HomeTeacherRepository {
  FutureEither<List<ClassEntities>> getClass();
  FutureEither<String> createClass({
    required String className,
    String? classDescription,
  });
}
