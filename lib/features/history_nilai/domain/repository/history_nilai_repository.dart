import 'package:fpdart/fpdart.dart';
import 'package:test_potensial/core/message/failure_message.dart';
import 'package:test_potensial/features/history_nilai/domain/entities/history_nilai_entities.dart';

abstract interface class HistoryNilaiRepository {
  Future<Either<FailureMessage, List<HistoryNilaiEntities>>> getHistoryNilai();
}
