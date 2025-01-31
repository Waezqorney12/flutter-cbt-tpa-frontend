import 'package:fpdart/fpdart.dart';
import 'package:test_potensial/core/message/failure_message.dart';
import 'package:test_potensial/core/utils/function_helper_utils.dart';
import 'package:test_potensial/features/student/history_nilai/domain/repository/history_nilai_repository.dart';

import '../../domain/datasource/history_nilai_remote_datasource.dart';
import '../../domain/entities/history_nilai_entities.dart';

final class HistoryNilaiRepositoryImpl implements HistoryNilaiRepository {
  final HistoryNilaiRemoteDatasource _historyNilaiRemoteDatasource;

  HistoryNilaiRepositoryImpl({required HistoryNilaiRemoteDatasource historyNilaiRemoteDatasource})
      : _historyNilaiRemoteDatasource = historyNilaiRemoteDatasource;

  @override
  Future<Either<FailureMessage, List<HistoryNilaiEntities>>> getHistoryNilai() async {
    return helperCall<List<HistoryNilaiEntities>>(
      apiCall: () => _historyNilaiRemoteDatasource.getHistoryNilai(),
    );
  }
}
