import 'package:test_potensial/core/utils/function_helper_utils.dart';
import 'package:test_potensial/core/utils/typedef_utils.dart';
import 'package:test_potensial/features/materi/domain/datasource/materi_remote_datasource.dart';
import 'package:test_potensial/features/materi/domain/entities/materi_entities.dart';
import 'package:test_potensial/features/materi/domain/repository/materi_repository.dart';

class MateriRepositoryImpl implements MateriRepository {
  final MateriRemoteDataSource _remoteDataSource;
  const MateriRepositoryImpl(this._remoteDataSource);
  @override
  FutureEither<List<MateriEntities>> getMateri({String? kategori}) =>
      helperCall<List<MateriEntities>>(apiCall: () => _remoteDataSource.getMateri(kategori: kategori));

  @override
  FutureEither<String> updateMateri(int id, int status) {
    return helperCall<String>(
      apiCall: () => _remoteDataSource.updateMateri(id, status),
    );
  }
}
