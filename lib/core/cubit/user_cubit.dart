import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_potensial/core/token/token_local_datasource.dart';
import 'package:test_potensial/core/utils/log.dart';

import '../entities/user_entities.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final TokenLocalDatasource _tokenLocalDatasource;

  UserCubit(TokenLocalDatasource tokenLocalDatasource)
      : _tokenLocalDatasource = tokenLocalDatasource,
        super(UserInitial());

  Future getUser() async {
    try {
      emit(UserLoading());
      final user = await _tokenLocalDatasource.getUser();
      Log.loggerInformation("User: $user");
      if (user.email?.isEmpty ?? false) {
        emit(const UserLoggeoOut(isLoggeoOut: true));
      } else {
        emit(UserLoggedIn(user));
      }
    } catch (e) {
      emit(
        UserError(e.toString()),
      );
    }
  }

  Future removeToken() async {
    try {
      emit(UserLoading());
      await _tokenLocalDatasource.removeToken();
      emit(const UserLoggeoOut(isLoggeoOut: true));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
