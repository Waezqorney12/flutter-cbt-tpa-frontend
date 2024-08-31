import 'package:fpdart/fpdart.dart';

import '../../../../core/message/failure_message.dart';
import '../../../../core/usecases/usecase_interface.dart';
import '../../../../core/usecases/usescase_no_params.dart';
import '../entities/materi_entities.dart';
import '../repository/materi_repository.dart';

class GetMateriUseCase implements UseCase<List<MateriEntities>, NoParams> {
  final MateriRepository repository;

  GetMateriUseCase(this.repository);

  @override
  Future<Either<FailureMessage, List<MateriEntities>>> call(NoParams params) async {
    return await repository.getMateri();
  }
}

class UpdateMateriUseCase implements UseCase<String, int> {
  final MateriRepository repository;

  UpdateMateriUseCase(this.repository);

  @override
  Future<Either<FailureMessage, String>> call(int id) async {
    return await repository.updateMateri(id);
  }
}
