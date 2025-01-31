import 'package:flutter/material.dart';
import 'package:test_potensial/features/teacher/home_teacher/domain/entities/kelas_entities.dart';

import '../../../../../core/config/api_config.dart';

class MemberModel extends MemberEntities {
  MemberModel({
    super.userId,
    super.userFirstName,
    super.userLastName,
    super.userProfile,
  });
  factory MemberModel.fromJson(Map<String, dynamic> json) {
    final path = '${ApiConfig.baseUrl}/storage/';
    return MemberModel(
        userId: json['user_id'] ?? 0,
        userFirstName: json['first_name'] ?? 'No first name',
        userLastName: json['last_name'] ?? 'No last name',
        userProfile: '$path${json['user_image_path']}');
  }
}

class ClassModel extends ClassEntities {
  ClassModel({
    super.classDetailId,
    super.classId,
    super.className,
    super.classDescription,
    super.classColor,
    super.classPin,
    super.classAuthor,
    super.createdAt,
    super.updatedAt,
    super.members,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
        classDetailId: json['class_detail_id'] ?? 0,
        classId: json['class_id'] ?? 0,
        className: json['class_name'] ?? 'No class',
        classDescription: json['class_description'] ?? 'No description',
        classColor: json['class_color'] != null
            ? Color(int.parse(json['class_color'].replaceAll('#', ''), radix: 16) + 0xFF000000)
            : Colors.black,
        classPin: json['class_pin'] ?? 'No pin',
        classAuthor: json['class_author'] ?? 'No author',
        members: json['members'] != null
            ? (json['members'] as List)
                .map(
                  (value) => MemberModel.fromJson(value),
                )
                .toList()
            : [],
        createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
        updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now());
  }

  Map<String, dynamic> toJson() {
    return {
      'class_name': className,
      'class_description': classDescription,
    };
  }
}
