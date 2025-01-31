class QuizQuestionEntities {
  final int questionId;
  final String? imagePath;
  final String question;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const QuizQuestionEntities({
    required this.questionId,
    this.imagePath,
    required this.question,
    this.createdAt,
    this.updatedAt,
  });
}
