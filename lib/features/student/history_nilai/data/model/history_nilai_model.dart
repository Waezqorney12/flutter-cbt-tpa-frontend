import 'package:test_potensial/features/student/history_nilai/domain/entities/history_nilai_entities.dart';

class HistoryNilaiModel extends HistoryNilaiEntities {
  HistoryNilaiModel({
    super.id,
    super.nilaiAngka,
    super.nilaiVerbal,
    super.nilaiLogika,
    super.hasil,
  });

  factory HistoryNilaiModel.fromJson(Map<String, dynamic> json) {
    return HistoryNilaiModel(
      id: json['id'] ?? 0,
      nilaiAngka: json['nilai_angka'] ?? 0,
      nilaiVerbal: json['nilai_verbal'] ?? 0,
      nilaiLogika: json['nilai_logika'] ?? 0,
      hasil: json['hasil'],
    );
  }
}
