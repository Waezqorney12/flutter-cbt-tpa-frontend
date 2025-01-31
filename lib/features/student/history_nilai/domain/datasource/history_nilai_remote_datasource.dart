import 'package:test_potensial/features/student/history_nilai/data/model/history_nilai_model.dart';

abstract interface class HistoryNilaiRemoteDatasource {
  Future<List<HistoryNilaiModel>> getHistoryNilai();
}
