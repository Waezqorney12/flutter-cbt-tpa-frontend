import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_potensial/core/model/user_model.dart';
import 'package:test_potensial/features/profile_detail/domain/usecase/profile_detail_usecase.dart';

import '../../../core/entities/user_entities.dart';

part 'profile_detail_state.dart';

class ProfileDetailCubit extends Cubit<ProfileDetailState> {
  final ProfileDetailUseCase _useCase;
  ProfileDetailCubit({required ProfileDetailUseCase useCase})
      : _useCase = useCase,
        super(ProfileDetailInitial());

  void changeProfile(UserModel userEntities) async {
    emit(ProfileDetailLoading());
    final resp = await _useCase.call(ProfileParams());
    resp.fold(
      (l) => emit(ProfileDetailFailed(l.message)),
      (r) => emit(ProfileDetailSuccess(r)),
    );
  }
}
