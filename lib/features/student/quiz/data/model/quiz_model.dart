import '../../domain/entities/quiz_thumbnail_entities.dart';

class QuizThumbnailModel extends QuizThumbnailEntities {
  QuizThumbnailModel(
      {required super.quizId,
      required super.title,
      required super.image,
      required super.description,
      required super.type,
      required super.category,
      required super.isDone});

  QuizThumbnailModel.fromJson(Map<String, dynamic> json)
      : super(
            quizId: json['id'] ?? 0,
            title: json['title'] ?? '',
            image: json['image'] ?? '',
            description: json['description'] ?? '',
            type: json['type'] ?? '',
            category: json['category'] ?? '',
            isDone: json['isDone'] ?? false);

  Map<String, dynamic> toJson() {
    return {
      'id': quizId,
      'title': title,
      'image': image,
      'description': description,
      'type': type,
      'category': category,
      'isDone': isDone
    };
  }
}
