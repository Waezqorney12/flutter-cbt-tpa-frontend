import 'package:fpdart/fpdart.dart';

import '../../../../core/failure/failure_message.dart';
import '../../../../core/usecases/usecase_interface.dart';
import '../../../../core/usecases/usescase_no_params.dart';
import '../entities/materi_entities.dart';
import '../repository/materi_repository.dart';

class GetMateri implements UseCase<List<MateriEntities>, NoParams> {
  final MateriRepository repository;

  GetMateri(this.repository);

  @override
  Future<Either<FailureMessage, List<MateriEntities>>> call(NoParams params) async => await repository.getMateri();
}
