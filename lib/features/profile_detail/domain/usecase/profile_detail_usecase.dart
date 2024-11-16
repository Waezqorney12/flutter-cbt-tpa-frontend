import 'dart:io';

import '../../../../core/entities/user_entities.dart';
import '../../../../core/usecases/usecase_interface.dart';
import '../../../../core/utils/typedef_utils.dart';
import '../repository/profile_detail_repository.dart';

class ProfileDetailUseCase implements UseCase<UserEntities, ProfileParams> {
  final ProfileDetailRepository _profileDetailRepository;
  ProfileDetailUseCase(this._profileDetailRepository);
  @override
  FutureEither<UserEntities> call(ProfileParams params) {
    return _profileDetailRepository.changeProfile(
      params.phone,
      params.firstName,
      params.lastName,
      params.email,
      params.image,
    );
  }
}

class ProfileParams {
  String? phone;
  String? firstName;
  String? lastName;
  String? email;
  File? image;
  ProfileParams({
    this.phone,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
  });
}
