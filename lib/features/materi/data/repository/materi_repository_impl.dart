import 'package:fpdart/fpdart.dart';
import 'package:test_potensial/core/failure/failure_message.dart';
import 'package:test_potensial/core/utils/function_helper_utils.dart';
import 'package:test_potensial/features/materi/domain/datasource/materi_remote_datasource.dart';
import 'package:test_potensial/features/materi/domain/entities/materi_entities.dart';
import 'package:test_potensial/features/materi/domain/repository/materi_repository.dart';

class MateriRepositoryImpl implements MateriRepository {
  final MateriRemoteDataSource _remoteDataSource;
  const MateriRepositoryImpl(this._remoteDataSource);
  @override
  Future<Either<FailureMessage, List<MateriEntities>>> getMateri() => helperCall(
        apiCall: () => _remoteDataSource.getMateri(),
      );
}
