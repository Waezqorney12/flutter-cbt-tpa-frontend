import 'package:test_potensial/features/quiz_detail/domain/entities/quiz_entities.dart';

class QuizModel extends QuizEntities {
  QuizModel({
    required super.id,
    required super.pertanyaan,
    required super.jawabanA,
    required super.jawabanB,
    required super.jawabanC,
    required super.jawabanD,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] ?? 0,
      pertanyaan: json['pertanyaan'] ?? '',
      jawabanA: json['jawaban_a'] ?? '',
      jawabanB: json['jawaban_b'] ?? '',
      jawabanC: json['jawaban_c'] ?? '',
      jawabanD: json['jawaban_d'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'pertanyaan': super.pertanyaan,
      'jawaban_a': super.jawabanA,
      'jawaban_b': super.jawabanB,
      'jawaban_c': super.jawabanC,
      'jawaban_d': super.jawabanD,
    };
  }
}
