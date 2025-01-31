import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_potensial/features/student/quiz/domain/usecase/quiz_thumbnail_usecase.dart';

import '../domain/entities/quiz_thumbnail_entities.dart';

part 'quiz_thumbnail_state.dart';

class QuizThumbnailCubit extends Cubit<QuizThumbnailState> {
  final QuizThumbnailUsecase _usecase;
  QuizThumbnailCubit({required QuizThumbnailUsecase thumbnailUsecase})
      : _usecase = thumbnailUsecase,
        super(QuizThumbnailInitial());

  Future getQuizThumbnail({String? kategori}) async {
    emit(QuizThumbnailLoading());
    final result = await _usecase(kategori);
    result.fold(
      (failure) => emit(QuizThumbnailError(failure.message)),
      (data) => emit(QuizThumbnailLoaded(data)),
    );
  }
}
