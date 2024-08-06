class QuizController {
  static final List<QuizModel> data = [
    QuizModel(
      title: 'Tes Angka',
      jenis: 'Multiple Choice',
      content:
          'Tes angka adalah suatu jenis tes psikometri yang dirancang untuk mengukur kemampuan individu dalam memahami, menganalisis, dan menyelesaikan masalah yang melibatkan angka dan matematika.',
    ),
    QuizModel(
      title: 'Tes Logika',
      jenis: 'True or False',
      content:
          'Tes logika adalah metode evaluasi yang digunakan untuk mengukur kemampuan seseorang dalam berpikir secara logis, analitis, dan rasional',
    ),
    QuizModel(
      title: 'Tes Verbal',
      jenis: 'Multiple Choice',
      content:
          'Tes verbal adalah suatu metode evaluasi yang digunakan untuk mengukur kemampuan seseorang dalam menggunakan dan memahami bahasa lisan atau tertulis.',
    ),
  ];
}

class QuizModel {
  final String title;
  final String jenis;
  final String content;

  QuizModel({
    required this.title,
    required this.jenis,
    required this.content,
  });
}
