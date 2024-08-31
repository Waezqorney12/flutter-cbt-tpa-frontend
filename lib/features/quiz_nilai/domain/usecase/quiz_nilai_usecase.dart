import 'package:fpdart/fpdart.dart';
import 'package:test_potensial/features/quiz_nilai/domain/entities/quiz_nilai_entities.dart';

import '../../../../core/message/failure_message.dart';
import '../../../../core/usecases/usecase_interface.dart';
import '../repository/quiz_nilai_repository.dart';

final class GetNilaiJawabanUseCase implements UseCase<QuizNilaiEntities, String> {
  final QuizNilaiRepository _repository;
  const GetNilaiJawabanUseCase(this._repository);

  @override
  Future<Either<FailureMessage, QuizNilaiEntities>> call(String params) async {
    return await _repository.getNilaiQuiz(params);
  }
}
