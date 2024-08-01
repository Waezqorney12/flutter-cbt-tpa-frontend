import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_potensial/features/auth/domain/usecases/user_register_usecases.dart';

import '../domain/entities/user_entities.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRegister _userRegister;
  AuthBloc({
    required UserRegister userRegister,
  })  : _userRegister = userRegister,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) => emit(AuthLoading()));
    on<RegisterEvent>(
      (event, emit) async {
        final response = await _userRegister(
          UserRegisterParams(email: event.email, password: event.password, name: event.name),
        );
        response.fold(
          (l) => emit(AuthError(l.message)),
          (r) => emit(AuthSuccess(r)),
        );
      },
    );
  }
}
