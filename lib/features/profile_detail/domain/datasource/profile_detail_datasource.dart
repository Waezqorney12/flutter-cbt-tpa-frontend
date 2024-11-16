import 'dart:io';

import 'package:test_potensial/core/model/user_model.dart';

abstract interface class ProfileDetailDatasource {
  Future<UserModel> changeProfile(
    String? phone,
    String? firstName,
    String? lastName,
    String? email,
    File? image,
  );
}
