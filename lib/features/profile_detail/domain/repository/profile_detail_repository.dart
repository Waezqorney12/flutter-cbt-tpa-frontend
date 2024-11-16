import 'dart:io';

import 'package:test_potensial/core/entities/user_entities.dart';
import 'package:test_potensial/core/utils/typedef_utils.dart';

abstract interface class ProfileDetailRepository {
  FutureEither<UserEntities> changeProfile(
    String? phone,
    String? firstName,
    String? lastName,
    String? email,
    File? image,
  );
}
