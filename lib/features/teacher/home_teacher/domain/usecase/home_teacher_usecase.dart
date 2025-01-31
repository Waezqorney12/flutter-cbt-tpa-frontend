import 'package:test_potensial/core/usecases/usecase_interface.dart';
import 'package:test_potensial/core/usecases/usescase_no_params.dart';
import 'package:test_potensial/core/utils/typedef_utils.dart';
import 'package:test_potensial/features/teacher/home_teacher/domain/entities/kelas_entities.dart';
import 'package:test_potensial/features/teacher/home_teacher/domain/home_teacher_repository/home_teacher_repository.dart';

class GetClassUseCase implements UseCase<List<ClassEntities>, NoParams> {
  final HomeTeacherRepository _repository;
  const GetClassUseCase(this._repository);
  @override
  FutureEither<List<ClassEntities>> call(NoParams params) async {
    return await _repository.getClass();
  }
}

class CreateUseCase implements UseCase<String, CreateClassParams> {
  final HomeTeacherRepository _repository;
  const CreateUseCase(this._repository);
  @override
  FutureEither<String> call(CreateClassParams params) async {
    return await _repository.createClass(
      className: params.className,
      classDescription: params.classDescription,
    );
  }
}

class CreateClassParams {
  final String className;
  final String? classDescription;

  const CreateClassParams(this.className, this.classDescription);
}
