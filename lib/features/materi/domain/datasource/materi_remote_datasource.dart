import 'package:test_potensial/features/materi/data/model/materi_model.dart';

abstract interface class MateriRemoteDataSource {
  Future<List<MateriModel>> getMateri();
}