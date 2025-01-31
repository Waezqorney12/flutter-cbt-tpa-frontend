class QuizBaseResponseEntities {
  final String message;
  final List<QuizEntities> quizEntities;

  const QuizBaseResponseEntities({
    required this.message,
    required this.quizEntities,
  });
}

class QuizEntities {
  final int id;
  final int quizId;
  final int userId;
  final QuizzesDetailsEntities quizDetails;

  const QuizEntities({
    required this.id,
    required this.quizId,
    required this.userId,
    required this.quizDetails,
  });
}

class QuizzesDetailsEntities {
  final int? quizQuestionId;
  final String? quizImagePath;
  final String? quizQuestion;
  final String? choiceA;
  final String? choiceB;
  final String? choiceC;
  final String? choiceD;
  final String? correctAnswer;
  final String? answer;
  final int? isCorrect;

  const QuizzesDetailsEntities({
    this.quizQuestionId,
    this.quizImagePath,
    this.quizQuestion,
    this.choiceA,
    this.choiceB,
    this.choiceC,
    this.choiceD,
    this.correctAnswer,
    this.answer,
    this.isCorrect,
  });
}
