import 'package:test_potensial/core/utils/typedef_utils.dart';
import 'package:test_potensial/features/student/quiz_nilai/domain/entities/quiz_nilai_entities.dart';

import '../../../../../core/usecases/usecase_interface.dart';
import '../../../quiz_detail/domain/usecase/quiz_usecase.dart';
import '../repository/quiz_nilai_repository.dart';

final class GetNilaiJawabanUseCase implements UseCase<QuizNilaiEntities, UserQuizParams> {
  final QuizNilaiRepository _repository;
  const GetNilaiJawabanUseCase(this._repository);

  @override
  FutureEither<QuizNilaiEntities> call(UserQuizParams params) async {
    return await _repository.getNilaiQuiz(params: params);
  }
}
