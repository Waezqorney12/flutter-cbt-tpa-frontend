import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:test_potensial/core/usecases/usecase_interface.dart';

import '../../../../core/failure/failure_message.dart';
import '../entities/quiz_entities.dart';
import '../repository/quiz_detail_repository.dart';

final class GetQuizDetailUseCase implements UseCase<List<QuizEntities>, String> {
  final QuizDetailRepository _repository;

  const GetQuizDetailUseCase(this._repository);

  @override
  Future<Either<FailureMessage, List<QuizEntities>>> call(String kategori) async {
    return await _repository.getQuizDetail(kategori);
  }
}

