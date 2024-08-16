import 'package:test_potensial/features/materi/domain/entities/materi_entities.dart';

class MateriModel extends MateriEntities {
  MateriModel({
    super.id,
    super.title,
    super.name,
    super.description,
    super.image,
    super.dateTime,
    super.kategori,
    super.value,
  });

  factory MateriModel.fromJson(Map<String, dynamic> json) {
    return MateriModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'],
      dateTime: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      kategori: json['kategori'] ?? '',
      value: json['pivot']['value'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'materi_id': super.id,
      'value': super.value,
    };
  }
}
