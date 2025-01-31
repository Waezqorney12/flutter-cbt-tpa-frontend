import 'package:flutter/material.dart';

class ClassEntities {
  final int? classDetailId;
  final int? classId;
  final String? className;
  final String? classDescription;
  final Color? classColor;
  final String? classPin;
  final String? classAuthor;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<MemberEntities>? members;

  const ClassEntities({
    this.classDetailId,
    this.classId,
    this.className,
    this.classDescription,
    this.classColor,
    this.classPin,
    this.classAuthor,
    this.createdAt,
    this.updatedAt,
    this.members,
  });
}

class MemberEntities {
  final int? userId;
  final String? userFirstName;
  final String? userLastName;
  final String? userProfile;

  const MemberEntities({
    required this.userId,
    required this.userFirstName,
    required this.userLastName,
    required this.userProfile,
  });
}
