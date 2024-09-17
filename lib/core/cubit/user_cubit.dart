import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_potensial/core/token/token_local_datasource.dart';
import 'package:test_potensial/core/utils/log.dart';

import '../entities/user_entities.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final TokenLocalDatasource _tokenLocalDatasource;
  StreamSubscription<UserEntities>? _userSubscription;

  UserCubit(TokenLocalDatasource tokenLocalDatasource)
      : _tokenLocalDatasource = tokenLocalDatasource,
        super(UserInitial()) {
    _startListeningToUserUpdates();
  }

  void _startListeningToUserUpdates() {
    emit(UserLoading());
    _userSubscription?.cancel();
    _userSubscription = _tokenLocalDatasource.getUser().listen(
      (user) {
        if (user.email?.isEmpty ?? false) {
          Log.loggerInformation('User Logged Out');
          emit(const UserLoggeoOut(isLoggeoOut: true));
        } else {
          Log.loggerInformation('User Logged In: $user');
          emit(UserLoggedIn(user));
        }
        Log.loggerInformation('User: $user');
      },
      onError: (e) {
        emit(UserError(e.toString()));
        Log.loggerFatal('Error receiving user updates: $e');
      },
    );
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    _tokenLocalDatasource.disposeWebSocket();
    return super.close();
  }

  Future removeToken() async {
    try {
      emit(UserLoading());
      final user = await _tokenLocalDatasource.removeToken();
      //Log.loggerTrace('UserCubit Remove Token: $user');
      isLoggedIn.value = false;
      emit(UserLoggeoOut(isLoggeoOut: user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
