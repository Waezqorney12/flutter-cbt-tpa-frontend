import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_potensial/features/quiz_detail/domain/usecase/quiz_usecase.dart';

import '../domain/entities/quiz_entities.dart';

part 'quiz_detail_event.dart';
part 'quiz_detail_state.dart';

class QuizDetailBloc extends Bloc<QuizDetailEvent, QuizDetailState> {
  final GetQuizDetail _getQuizDetail;
  QuizDetailBloc({required GetQuizDetail getQuizDetail})
      : _getQuizDetail = getQuizDetail,
        super(QuizDetailInitial()) {
    on<QuizDetailEvent>((event, emit) => QuizDetailLoading());

    on<GetQuizDetailEvent>((event, emit) async {
      final result = await _getQuizDetail(event.kategori);
      result.fold((failure) => emit(QuizDetailError(failure.message)), (quizEntities) {
        emit(QuizDetailLoaded(quizEntities));
      });
    });
    on<QuizDetailReset>((event, emit) => emit(QuizDetailInitial()));
  }
}
