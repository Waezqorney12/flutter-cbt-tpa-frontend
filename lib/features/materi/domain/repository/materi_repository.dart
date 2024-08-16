import 'package:fpdart/fpdart.dart';
import 'package:test_potensial/core/failure/failure_message.dart';

import '../entities/materi_entities.dart';

abstract interface class MateriRepository {
  Future<Either<FailureMessage, List<MateriEntities>>> getMateri();
  Future<Either<FailureMessage, String>> updateMateri(int id);
}
