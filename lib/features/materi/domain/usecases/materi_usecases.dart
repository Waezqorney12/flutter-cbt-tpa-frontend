import 'package:fpdart/fpdart.dart';

import '../../../../core/message/failure_message.dart';
import '../../../../core/usecases/usecase_interface.dart';
import '../entities/materi_entities.dart';
import '../repository/materi_repository.dart';

class GetMateriUseCase implements UseCase<List<MateriEntities>, String?> {
  final MateriRepository repository;

  GetMateriUseCase(this.repository);

  @override
  Future<Either<FailureMessage, List<MateriEntities>>> call(String? kategori) async {
    return await repository.getMateri(kategori: kategori);
  }
}

class UpdateMateriUseCase implements UseCase<String, UpdateParams> {
  final MateriRepository repository;

  UpdateMateriUseCase(this.repository);

  @override
  Future<Either<FailureMessage, String>> call(UpdateParams params) async {
    return await repository.updateMateri(params.id, params.status);
  }
}
class UpdateParams{
  final int id;
  final int status;

  UpdateParams({required this.id, required this.status});
}
