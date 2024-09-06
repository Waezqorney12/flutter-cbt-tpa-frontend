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
    startListeningToUserUpdates();
  }

  void startListeningToUserUpdates() {
    emit(UserLoading());
    _userSubscription?.cancel();
    _userSubscription = _tokenLocalDatasource.getUser().listen((user) {
      Log.loggerFatal('UserCubit Start Listening To User : ${user.name}');
      if (user.email?.isEmpty ?? false) {
        emit(const UserLoggeoOut(isLoggeoOut: true));
      } else {
        emit(UserLoggedIn(user));
      }
    }, onError: (e) {
      emit(UserError(e.toString()));
    });
    Log.loggerTrace('UserCubit Start Listening To User Updates:$_userSubscription');
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  Future removeToken() async {
    try {
      emit(UserLoading());
      final user = await _tokenLocalDatasource.removeToken();
      Log.loggerTrace('UserCubit Remove Token: $user');
      emit(UserLoggeoOut(isLoggeoOut: user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
