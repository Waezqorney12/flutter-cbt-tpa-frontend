import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_detail_form/domain/usecase/quiz_teacher_detail_form_question_usecase.dart';

part 'quiz_detail_form_question_state.dart';

class QuizDetailFormQuestionCubit extends Cubit<QuizDetailFormQuestionState> {
  final QuizTeacherDetailFormQuestionUsecase _usecase;
  QuizDetailFormQuestionCubit(QuizTeacherDetailFormQuestionUsecase usecase)
      : _usecase = usecase,
        super(QuizDetailFormQuestionInitial());

  Future createQuestion(QuizTeacherDetailFormParams params) async {
    emit(QuizDetailFormQuestionLoading());
    final request = await _usecase.call(params);
    request.fold(
      (failure) => emit(QuizDetailFormQuestionError(failure.message)),
      (data) => emit(QuizDetailFormQuestionSuccess(data)),
    );
  }
}
