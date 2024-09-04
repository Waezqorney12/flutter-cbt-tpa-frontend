import 'package:test_potensial/core/model/user_model.dart';

abstract interface class ProfileDetailDatasource {
  Future<UserModel> changeProfile(
    String? phone,
    String? name,
    String? email,
  );
}
