class MateriEntities {
  final int? id;
  final String? kategori;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final MateriAttributes? materi;

  const MateriEntities({
    this.id,
    this.kategori,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.materi,
  });
}

class MateriAttributes {
  final String? title;
  final String? description;
  final String? image;

  const MateriAttributes({
    this.title,
    this.description,
    this.image,
  });
}
