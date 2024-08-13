import 'package:test_potensial/features/materi/domain/entities/materi_entities.dart';

class MateriModel extends MateriEntities {
  MateriModel({
    required super.title,
    required super.name,
    required super.description,
    required super.image,
    required super.dateTime,
    required super.kategori,
    required super.value,
  });

  factory MateriModel.fromJson(Map<String, dynamic> json) {
    return MateriModel(
      title: json['title'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      dateTime: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      kategori: json['kategori'],
      value: json['value'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': super.name,
  //     'description': super.description,
  //     'image': super.image,
  //     'dateTime': super.dateTime.toIso8601String(),
  //     'value': super.value,
  //   };
  // }
}
