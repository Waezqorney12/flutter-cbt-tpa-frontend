class FormQuizEntities {
  final int id;
  final String title;
  String? questionImage;
  final String? choiceA;
  final String? choiceB;
  final String? choiceC;
  final String? choiceD;
  final String correctAnswer;

  FormQuizEntities({
    required this.id,
    required this.title,
    this.questionImage,
    this.choiceA,
    this.choiceB,
    this.choiceC,
    this.choiceD,
    required this.correctAnswer,
  });
}
