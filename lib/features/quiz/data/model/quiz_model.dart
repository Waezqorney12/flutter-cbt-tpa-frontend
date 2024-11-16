

import '../../domain/entities/quiz_thumbnail_entities.dart';

class QuizThumbnailModel extends QuizThumbnailEntities{
  QuizThumbnailModel({
    required super.title,
    required super.image,
    required super.description,
    required super.type,
    required super.category,
  });

  QuizThumbnailModel.fromJson(Map<String, dynamic> json) : super(
    title: json['title'] ?? '',
    image:json['image'] ?? '',
    description: json['description'] ?? '',
    type: json['type'] ?? '',
    category: json['category'] ?? '',
  );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': image,
      'description': description,
      'type': type,
      'category': category,
    };
  }
}