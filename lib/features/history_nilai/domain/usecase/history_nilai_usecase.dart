import 'package:fpdart/fpdart.dart';
import 'package:test_potensial/core/message/failure_message.dart';
import 'package:test_potensial/core/usecases/usecase_interface.dart';
import 'package:test_potensial/core/usecases/usescase_no_params.dart';
import 'package:test_potensial/features/history_nilai/domain/entities/history_nilai_entities.dart';
import 'package:test_potensial/features/history_nilai/domain/repository/history_nilai_repository.dart';

class HistoryNilaiUsecase implements UseCase<List<HistoryNilaiEntities>, NoParams> {
  final HistoryNilaiRepository _historyNilaiRepository;
  const HistoryNilaiUsecase(this._historyNilaiRepository);
  @override
  Future<Either<FailureMessage, List<HistoryNilaiEntities>>> call(NoParams params) {
    return _historyNilaiRepository.getHistoryNilai();
  }
}
