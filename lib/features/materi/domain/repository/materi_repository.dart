import 'package:test_potensial/core/utils/typedef_utils.dart';

import '../entities/materi_entities.dart';

abstract interface class MateriRepository {
  FutureEither<List<MateriEntities>> getMateri();
  FutureEither<String> updateMateri(int id);
}
