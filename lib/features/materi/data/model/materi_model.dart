import 'package:test_potensial/features/materi/domain/entities/materi_entities.dart';

class MateriAttributesModel extends MateriAttributes {
  const MateriAttributesModel({
    super.title,
    super.description,
    super.image,
  });

  factory MateriAttributesModel.fromJson(Map<String, dynamic> json) {
    return MateriAttributesModel(
      title: json['materi_title'],
      description: json['materi_description'],
      image: json['materi_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'materi_title': title,
      'materi_description': description,
      'materi_image': image,
    };
  }
}

class MateriModel extends MateriEntities {
  MateriModel({
    super.id,
    super.kategori,
    super.status,
    super.createdAt,
    super.updatedAt,
    super.materi,
  });

  factory MateriModel.fromJson(Map<String, dynamic> json) {
    return MateriModel(
      id: json['materi_id'] ?? 0,
      kategori: json['materi_kategori'] ?? '',
      status: json['status'] ?? 0,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
      materi: json['materi'] != null ? MateriAttributesModel.fromJson(json['materi']) : const MateriAttributesModel(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'materi_id': id,
      'materi_kategori': kategori,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'materi': (materi as MateriAttributesModel).toJson(),
    };
  }
}

final class MateriBaseResponse {
  final String message;
  final List<MateriModel> materi;
  const MateriBaseResponse({
    required this.message,
    required this.materi,
  });

  factory MateriBaseResponse.fromJson(Map<String, dynamic> json) {
    return MateriBaseResponse(
      message: json['message'],
      materi: (json['data'] as List).map((e) => MateriModel.fromJson(e)).toList(),
    );
  }
}
