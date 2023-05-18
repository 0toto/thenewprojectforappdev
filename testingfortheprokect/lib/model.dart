import './database_helper.dart';

class QandA {
  int id;
  int quizId;
  String question;
  String answer;

  QandA({
    required this.id,
    required this.quizId,
    required this.question,
    required this.answer,
  });

  factory QandA.fromMap(Map<String, dynamic> map) {
    return QandA(
      id: map[DataBaseHelper.columnIdQandA],
      quizId: map[DataBaseHelper.columnQuizId],
      question: map[DataBaseHelper.columnQuestion],
      answer: map[DataBaseHelper.columnAnswer],
    );
  }
}

class Quiz {
  int id;
  String name;


  Quiz({
    required this.id,
    required this.name,
  });

  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      id: map[DataBaseHelper.columnIdQuiz],
      name: map[DataBaseHelper.columnNameQuiz],
    );
  }
}