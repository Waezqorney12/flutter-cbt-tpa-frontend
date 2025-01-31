import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_potensial/core/usecases/usescase_no_params.dart';
import 'package:test_potensial/features/teacher/home_teacher/domain/usecase/home_teacher_usecase.dart';

import '../domain/entities/kelas_entities.dart';

part 'home_teacher_event.dart';
part 'home_teacher_state.dart';

class HomeTeacherBloc extends Bloc<HomeTeacherEvent, HomeTeacherState> {
  final GetClassUseCase _getClassUseCase;
  final CreateUseCase _createUseCase;
  HomeTeacherBloc({
    required GetClassUseCase getClassUseCase,
    required CreateUseCase createUseCase,
  })  : _getClassUseCase = getClassUseCase,
        _createUseCase = createUseCase,
        super(HomeTeacherInitial()) {
    on<HomeTeacherEvent>((event, emit) => emit(HomeTeacherLoading()));
    on<GetClassEvent>(
      (event, emit) async {
        final response = await _getClassUseCase.call(NoParams());
        response.fold(
          (failure) => emit(HomeTeacherError(failure.message)),
          (data) => emit(HomeTeacherLoaded(data)),
        );
      },
    );
    on<CreateClassEvent>(
      (event, emit) async {
        final response = await _createUseCase.call(event.classes);
        response.fold(
          (failure) => emit(HomeTeacherError(failure.message)),
          (data) => emit(HomeTeacherSuccess(data)),
        );
      },
    );
  }
}
