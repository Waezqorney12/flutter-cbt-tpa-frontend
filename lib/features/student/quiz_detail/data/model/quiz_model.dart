import 'package:test_potensial/features/student/quiz_detail/domain/entities/quiz_entities.dart';

class QuizBaseResponseModel extends QuizBaseResponseEntities {
  const QuizBaseResponseModel({
    required super.message,
    required super.quizEntities,
  });

  factory QuizBaseResponseModel.fromJson(Map<String, dynamic> json) {
    return QuizBaseResponseModel(
      message: json['message'] ?? '',
      quizEntities: json['data'] != null ? (json['data'] as List).map((e) => QuizModel.fromJson(e)).toList() : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': super.message,
      'data': super.quizEntities.map((e) => (e as QuizModel).toJson()).toList(),
    };
  }
}

class QuizModel extends QuizEntities {
  const QuizModel({
    required super.id,
    required super.quizId,
    required super.userId,
    required super.quizDetails,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] ?? 0,
      quizId: json['quiz_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      quizDetails: json['quizzes'] != null ? QuizzesDetailsModel.fromJson(json['quizzes']) : const QuizzesDetailsModel(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'quiz_id': super.quizId,
      'user_id': super.userId,
      'quizzes': (quizDetails as QuizzesDetailsModel).toJson(),
    };
  }
}

class QuizzesDetailsModel extends QuizzesDetailsEntities {
  const QuizzesDetailsModel({
    super.quizQuestionId,
    super.quizImagePath,
    super.quizQuestion,
    super.choiceA,
    super.choiceB,
    super.choiceC,
    super.choiceD,
    super.correctAnswer,
    super.answer,
    super.isCorrect,
  });

  factory QuizzesDetailsModel.fromJson(Map<String, dynamic> json) {
    return QuizzesDetailsModel(
      quizQuestionId: json['quiz_question_id'] ?? 0,
      quizImagePath: json['quiz_image_path'] ?? '',
      quizQuestion: json['question'] ?? '',
      choiceA: json['choice_a'] ?? '',
      choiceB: json['choice_b'] ?? '',
      choiceC: json['choice_c'] ?? '',
      choiceD: json['choice_d'] ?? '',
      correctAnswer: json['correct_answer'] ?? '',
      answer: json['answer'] ?? '',
      isCorrect: json['is_correct'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quiz_question_id': super.quizQuestionId,
      'quiz_image_path': super.quizImagePath,
      'question': super.quizQuestion,
      'choice_a': super.choiceA,
      'choice_b': super.choiceB,
      'choice_c': super.choiceC,
      'choice_d': super.choiceD,
      'correct_answer': super.correctAnswer,
      'answer': super.answer,
      'is_correct': super.isCorrect,
    };
  }
}
