import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_potensial/core/token/token_local_datasource.dart';

import '../entities/user_entities.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final TokenLocalDatasource _tokenLocalDatasource;

  UserCubit(TokenLocalDatasource tokenLocalDatasource)
      : _tokenLocalDatasource = tokenLocalDatasource,
        super(UserInitial());
  Future<void> getUser() async {
    try {
      emit(UserLoading());
      final user = await _tokenLocalDatasource.getUser();
      emit(UserSuccess(user));
    } catch (e) {
      emit(
        UserError(e.toString()),
      );
    }
  }
}
