import 'package:equatable/equatable.dart';
import 'package:test_potensial/core/usecases/usecase_interface.dart';
import 'package:test_potensial/core/utils/typedef_utils.dart';

import '../entities/quiz_entities.dart';
import '../repository/quiz_detail_repository.dart';

final class GetQuizDetailUseCase implements UseCase<QuizBaseResponseEntities, GetDetailQuizParams> {
  final QuizDetailRepository _repository;

  const GetQuizDetailUseCase(this._repository);

  @override
  FutureEither<QuizBaseResponseEntities> call(GetDetailQuizParams params) async {
    return await _repository.getQuizDetail(params);
  }
}


final class UserExitUseCase implements UseCase<String, UserQuizParams> {
  final QuizDetailRepository _repository;

  const UserExitUseCase(this._repository);

  @override
  FutureEither<String> call(UserQuizParams params) async {
    return await _repository.userExit(quizId: params.quizId, data: params.data);
  }
}

final class UserQuizParams extends Equatable {
  final int quizId;
  final List<List<dynamic>> data;

  const UserQuizParams({
    required this.quizId,
    required this.data,
  });
  @override
  List<Object?> get props => [quizId, data];
}

final class GetDetailQuizParams extends Equatable {
  final int id;
  final String type;
  const GetDetailQuizParams(this.id, this.type);
  @override
  List<Object?> get props => [id, type];
}
