import 'package:test_potensial/features/history_nilai/data/model/history_nilai_model.dart';

abstract interface class HistoryNilaiRemoteDatasource {
  Future<List<HistoryNilaiModel>> getHistoryNilai();
}
