import '../../../../../core/config/api_config.dart';
import '../../domain/entities/form_quiz_entities.dart';

class FormQuizModel extends FormQuizEntities {
  FormQuizModel({
    required super.id,
    required super.title,
    super.questionImage,
    required super.choiceA,
    required super.choiceB,
    required super.choiceC,
    required super.choiceD,
    required super.correctAnswer,
  });

  factory FormQuizModel.fromJson(Map<String, dynamic> json) {
    return FormQuizModel(
        id: json['id'],
        questionImage: '${ApiConfig.baseUrl}/storage/${json['quiz_image_path']}',
        title: json['title'] ?? '',
        choiceA: json['choiceA'] ?? '',
        choiceB: json['choiceB'] ?? '',
        choiceC: json['choiceC'] ?? '',
        choiceD: json['choiceD'] ?? '',
        correctAnswer: json[' correctAnswer'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'choiceA': choiceA,
      'choiceB': choiceB,
      'choiceC': choiceC,
      'choiceD': choiceD,
      'correctAnswer': correctAnswer,
    };
  }
}
