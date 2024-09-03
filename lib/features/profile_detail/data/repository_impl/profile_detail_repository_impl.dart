import 'package:test_potensial/core/entities/user_entities.dart';
import 'package:test_potensial/core/model/user_model.dart';
import 'package:test_potensial/core/utils/function_helper_utils.dart';

import 'package:test_potensial/core/utils/typedef_utils.dart';

import '../../domain/datasource/profile_detail_datasource.dart';
import '../../domain/repository/profile_detail_repository.dart';

class ProfileDetailRepositoryImpl implements ProfileDetailRepository {
  final ProfileDetailDatasource _profileDetailDatasource;
  ProfileDetailRepositoryImpl(this._profileDetailDatasource);
  @override
  FutureEither<UserEntities> changeProfile(
    String? phone,
    String? name,
    String? email,
    String? password,
  ) {
    return helperCall<UserEntities>(
      apiCall: () => _profileDetailDatasource.changeProfile(
        phone,
        name,
        email,
        password,
      ),
    );
  }
}
