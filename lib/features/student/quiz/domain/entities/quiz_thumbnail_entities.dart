class QuizThumbnailEntities {
  final int quizId;
  final String title;
  final String image;
  final String description;
  final String type;
  final String category;
  final bool isDone;

  QuizThumbnailEntities({
    required this.quizId,
    required this.title,
    required this.image,
    required this.description,
    required this.type,
    required this.category,
    required this.isDone,
  });
}
