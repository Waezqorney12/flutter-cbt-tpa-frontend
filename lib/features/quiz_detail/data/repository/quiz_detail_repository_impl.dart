import 'package:fpdart/fpdart.dart';
import 'package:test_potensial/core/failure/failure_message.dart';
import 'package:test_potensial/core/utils/function_helper_utils.dart';
import 'package:test_potensial/features/quiz_detail/domain/datasource/remote_quiz_detail_datasource.dart';
import 'package:test_potensial/features/quiz_detail/domain/entities/quiz_entities.dart';
import 'package:test_potensial/features/quiz_detail/domain/repository/quiz_detail_repository.dart';
import 'package:test_potensial/features/quiz_detail/domain/usecase/quiz_usecase.dart';

class QuizDetailRepositoryImpl implements QuizDetailRepository {
  final RemoteQuizDetailDatasource _remoteQuizDetailDatasource;
  const QuizDetailRepositoryImpl(this._remoteQuizDetailDatasource);
  @override
  Future<Either<FailureMessage, List<QuizEntities>>> getQuizDetail(String kategori) {
    return helperCall<List<QuizEntities>>(
      apiCall: () => _remoteQuizDetailDatasource.getQuizDetail(kategori),
    );
  }

  @override
  Future<Either<FailureMessage, String>> createJawabanDetail(CreateJawabanParams params) {
    return helperCall<String>(
      apiCall: () => _remoteQuizDetailDatasource.createJawabanDetail(params),
    );
  }


}
