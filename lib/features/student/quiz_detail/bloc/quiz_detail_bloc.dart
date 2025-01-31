import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_potensial/features/student/quiz_detail/domain/usecase/quiz_usecase.dart';

import '../domain/entities/quiz_entities.dart';

part 'quiz_detail_event.dart';
part 'quiz_detail_state.dart';

class QuizDetailBloc extends Bloc<QuizDetailEvent, QuizDetailState> {
  final GetQuizDetailUseCase _getQuizDetail;
  final UserExitUseCase _userExitUseCase;
  QuizDetailBloc({
    required UserExitUseCase userExitUseCase,
    required GetQuizDetailUseCase getQuizDetail,
  })  : _getQuizDetail = getQuizDetail,
        _userExitUseCase = userExitUseCase,
        super(QuizDetailInitial()) {
    on<QuizDetailEvent>((event, emit) => emit(QuizDetailLoading()));

    on<GetQuizDetailEvent>((event, emit) async {
      final result = await _getQuizDetail(event.params);

      result.fold((failure) => emit(QuizDetailError(failure.message)), (baseResponse) {
        emit(QuizDetailLoaded(baseResponse));
      });
    });

    on<UserExitEvent>(
      (event, emit) async {
        final result = await _userExitUseCase.call(event.params);
        result.fold(
          (l) => QuizDetailError(l.message),
          (r) => emit(QuizUserExit()),
        );
      },
    );
  }
}
