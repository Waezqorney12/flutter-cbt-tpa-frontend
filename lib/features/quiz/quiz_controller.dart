class QuizController {
  static final List<QuizCategoryModel> data = [
    QuizCategoryModel(
      title: 'Numeric',
      jenis: 'Multiple Choice',
      content:
          'Tes numeric adalah suatu jenis tes psikometri yang dirancang untuk mengukur kemampuan individu dalam memahami, menganalisis, dan menyelesaikan masalah yang melibatkan angka dan matematika.',
    ),
    QuizCategoryModel(
      title: 'Logika',
      jenis: 'True or False',
      content:
          'Tes logika adalah metode evaluasi yang digunakan untuk mengukur kemampuan seseorang dalam berpikir secara logis, analitis, dan rasional',
    ),
    QuizCategoryModel(
      title: 'Verbal',
      jenis: 'Multiple Choice',
      content:
          'Tes verbal adalah suatu metode evaluasi yang digunakan untuk mengukur kemampuan seseorang dalam menggunakan dan memahami bahasa lisan atau tertulis.',
    ),
  ];
}

class QuizCategoryModel {
  final String title;
  final String jenis;
  final String content;

  QuizCategoryModel({
    required this.title,
    required this.jenis,
    required this.content,
  });
}
