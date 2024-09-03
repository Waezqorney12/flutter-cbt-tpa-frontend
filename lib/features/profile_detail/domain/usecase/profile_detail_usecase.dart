import '../../../../core/entities/user_entities.dart';
import '../../../../core/model/user_model.dart';
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
      params.name,
      params.email,
      params.password,
    );
  }
}

class ProfileParams {
  String? phone;
  String? name;
  String? email;
  String? password;
  ProfileParams({
    this.phone,
    this.name,
    this.email,
    this.password,
  });
}
