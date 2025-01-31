import '../../domain/entities/quiz_nilai_entities.dart';

class QuizNilaiModel extends QuizNilaiEntities {
  QuizNilaiModel({
    required super.id,
    required super.totalSoal,
    required super.totalBenar,
    required super.totalSalah,
    required super.totalNilai,
    required super.score,
  });

  factory QuizNilaiModel.fromJson(Map<String, dynamic> json) {
    return QuizNilaiModel(
      id: json['id'] ?? 0,
      totalSoal: json['totalSoal'] ?? 0,
      totalBenar: json['totalBenar'] ?? 0,
      totalSalah: json['totalSalah'] ?? 0,
      totalNilai: json['totalNilai'],
      score: json['score'] ?? 0,
    );
  }
}
