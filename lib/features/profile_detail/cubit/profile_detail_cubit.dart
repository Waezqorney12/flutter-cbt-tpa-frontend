import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_potensial/features/profile_detail/domain/usecase/profile_detail_usecase.dart';

import '../../../core/entities/user_entities.dart';

part 'profile_detail_state.dart';

class ProfileDetailCubit extends Cubit<ProfileDetailState> {
  final ProfileDetailUseCase _useCase;
  ProfileDetailCubit({required ProfileDetailUseCase useCase})
      : _useCase = useCase,
        super(ProfileDetailInitial());

  void changeProfile({
    String? phone,
    String? name,
    String? email,
  }) async {
    emit(ProfileDetailLoading());
    final resp = await _useCase.call(ProfileParams(
      email: email,
      name: name,
      phone: phone,
    ));
    resp.fold(
      (l) => emit(ProfileDetailFailed(l.message)),
      (r) {
        emit(ProfileDetailSuccess(r));
      },
    );
  }
}