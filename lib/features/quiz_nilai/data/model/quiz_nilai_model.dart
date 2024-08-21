import '../../domain/entities/quiz_nilai_entities.dart';

class QuizNilaiModel extends QuizNilaiEntities {
  QuizNilaiModel({
    required super.benar,
    required super.salah,
    required super.nilai,
  });

  factory QuizNilaiModel.fromJson(Map<String, dynamic> json) {
    return QuizNilaiModel(
      benar: json['total_benar'] ?? 0,
      salah: json['total_salah'] ?? 0,
      nilai: json['nilai'] ?? 0,
    );
  }
}
