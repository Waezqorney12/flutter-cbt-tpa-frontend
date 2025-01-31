import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_potensial/core/utils/log.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_detail_form/domain/entities/quiz_question_entities.dart';

import '../../domain/usecase/quiz_teacher_detail_form_usecase.dart';

part 'quiz_detail_form_state.dart';

class QuizDetailFormCubit extends Cubit<QuizDetailFormState> {
  final QuizTeacherDetailFormUsecase _usecase;

  QuizDetailFormCubit({required QuizTeacherDetailFormUsecase usecase})
      : _usecase = usecase,
        super(QuizDetailFormInitial());

  Future getQuestion({String? name}) async {
    emit(QuizDetailFormLoading());
    final response = await _usecase.call(name);
    Log.loggerFatal(response);
    response.fold(
      (failure) => emit(QuizDetailFormError(failure.message)),
      (data) => emit(QuizDetailFormLoaded(data)),
    );
  }
}
