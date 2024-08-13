import 'package:flutter/material.dart';
import 'package:test_potensial/features/materi/domain/entities/materi_entities.dart';

class MateriDetailScreen extends StatelessWidget {
  final MateriEntities _materi;
  const MateriDetailScreen({super.key, required MateriEntities materi}) : _materi = materi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Mater Detail Screen'),
      ),
    );
  }
}
