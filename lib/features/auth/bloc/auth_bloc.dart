import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_potensial/features/auth/domain/usecases/user_login_usecases.dart';
import 'package:test_potensial/features/auth/domain/usecases/user_register_usecases.dart';

import '../../../core/entities/user_entities.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRegisterUseCase _userRegister;
  final UserLoginUseCase _userLogin;
  AuthBloc({
    required UserRegisterUseCase userRegister,
    required UserLoginUseCase userLogin,
  })  : _userRegister = userRegister,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) => emit(AuthLoading()));
    on<RegisterEvent>(
      (event, emit) async {
        final response = await _userRegister(
          UserRegisterParams(email: event.email, password: event.password, name: event.name),
        );
        response.fold(
          (l) => emit(AuthError(l.message)),
          (r) => emit(AuthRegister(r)),
        );
      },
    );
    on<LoginEvent>(
      (event, emit) async {
        final response = await _userLogin(
          UserLoginParams(email: event.email, password: event.password),
        );
        response.fold(
          (l) => emit(AuthError(l.message)),
          (r) => emit(AuthLogin(r)),
        );
      },
    );
  }
}
