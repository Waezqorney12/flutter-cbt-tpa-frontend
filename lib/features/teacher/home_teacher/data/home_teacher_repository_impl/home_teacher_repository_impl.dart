import 'package:test_potensial/core/utils/function_helper_utils.dart';
import 'package:test_potensial/core/utils/typedef_utils.dart';
import 'package:test_potensial/features/teacher/home_teacher/domain/entities/kelas_entities.dart';
import 'package:test_potensial/features/teacher/home_teacher/domain/home_teacher_remote_datasource/home_teacher_remote_datasource.dart';
import 'package:test_potensial/features/teacher/home_teacher/domain/home_teacher_repository/home_teacher_repository.dart';

class HomeTeacherRepositoryImpl implements HomeTeacherRepository {
  final HomeTeacherRemoteDatasource _datasource;
  const HomeTeacherRepositoryImpl(this._datasource);
  @override
  FutureEither<String> createClass({required String className, String? classDescription}) {
    return helperCall<String>(
      apiCall: () => _datasource.createClass(
        className: className,
        classDescription: classDescription,
      ),
    );
  }

  @override
  FutureEither<List<ClassEntities>> getClass() {
    return helperCall<List<ClassEntities>>(
      apiCall: () => _datasource.getClass(),
    );
  }
}
