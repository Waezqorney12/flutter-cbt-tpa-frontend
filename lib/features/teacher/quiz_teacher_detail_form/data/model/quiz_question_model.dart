import 'package:test_potensial/core/config/api_config.dart';
import 'package:test_potensial/features/teacher/quiz_teacher_detail_form/domain/entities/quiz_question_entities.dart';

class QuizQuestionModel extends QuizQuestionEntities {
  QuizQuestionModel({
    required super.questionId,
    super.imagePath,
    required super.question,
    super.createdAt,
    super.updatedAt,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    final path = '${ApiConfig.baseUrl}/storage/';
    return QuizQuestionModel(
      questionId: json['id'] ?? 0,
      imagePath: '$path${json['quiz_image_path']}',
      question: json['question'] ?? '',
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quiz_image_path': imagePath,
      'question': question,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
