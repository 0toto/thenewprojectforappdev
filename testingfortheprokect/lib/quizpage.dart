import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'database_helper.dart';
import './model.dart';
import './homeMenu.dart';
import './profilePage.dart';
import './settingPage.dart';

class TestYourselfPage extends StatefulWidget {
  @override
  _TestYourselfPageState createState() => _TestYourselfPageState();
}

class _TestYourselfPageState extends State<TestYourselfPage> {
  int _currentIndex = 0;

  List<Quiz> quizzes = [];
  List<QandA> questions = [];
  List<bool> answerVisible = [];
  DataBaseHelper dbHelper = DataBaseHelper();

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  Future<void> initDatabase() async {
    try {
      await dbHelper.init();
      loadQuizzes();
    } catch (e) {
      print("Error initializing database: $e");
    }
  }

  Future<void> loadQuizzes() async {
    try {
      quizzes = await dbHelper.getAllQuizzes().then((list) {
        return list.map((item) => Quiz.fromMap(item)).toList();
      });
      setState(() {});
    } catch (e) {
      print("Error loading quizzes: $e");
    }
  }

  Future<void> loadQuestions(int quizId) async {
    try {
      questions = await dbHelper.getQandAsForQuiz(quizId).then((list) {
        return list.map((item) => QandA.fromMap(item)).toList();
      });
      answerVisible = List<bool>.filled(questions.length, false);
      setState(() {});
    } catch (e) {
      print("Error loading questions: $e");
    }
  }

  void toggleAnswerVisibility(int index) {
    setState(() {
      answerVisible[index] = !answerVisible[index];
    });
  }

  Future<void> deleteEverything() async {
    try {
      await dbHelper.deleteAllTables();
      loadQuizzes();
    } catch (e) {
      print("Error deleting everything: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizzes'),
      ),

      extendBody: false,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
        ),
        child: SizedBox(
          height: 100,
          child: FloatingNavbar(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.blue.shade700,
            borderRadius: 40,
            onTap: (int val) {
              setState(() {
                _currentIndex = val;
              });
              if (_currentIndex == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeMenu()),
                );
              }
              if (_currentIndex == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => profile()),
                );
              }
              if (_currentIndex == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => setting()),
                );
              }
            },
            currentIndex: _currentIndex,
            unselectedItemColor: Colors.grey,
            iconSize: 33,
            fontSize: 15,
            items: [
              FloatingNavbarItem(icon: Icons.home, title: 'Home'),
              FloatingNavbarItem(icon: Icons.person, title: 'Profile'),
              FloatingNavbarItem(icon: Icons.settings, title: 'Setting'),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blue.shade100,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: quizzes.length,
              itemBuilder: (context, index) {
                final quiz = quizzes[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        quiz.name,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizQuestionsPage(
                              quiz: quiz,
                              dbHelper: dbHelper,
                            ),
                          ),
                        );
                      },
                    ),
                    Divider(
                      thickness: 2.0,
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];
                return GestureDetector(
                  onTap: () {
                    toggleAnswerVisibility(index);
                  },
                  child: Container(
                    color: answerVisible[index] ? Colors.grey : Colors.white,
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question.question,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Visibility(
                          visible: answerVisible[index],
                          child: Text(
                            question.answer,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: deleteEverything,
            child: Text(
              'Delete Everything',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class QuizQuestionsPage extends StatefulWidget {
  final Quiz quiz;
  final DataBaseHelper dbHelper;

  QuizQuestionsPage({
    required this.quiz,
    required this.dbHelper,
  });

  @override
  _QuizQuestionsPageState createState() => _QuizQuestionsPageState();
}

class _QuizQuestionsPageState extends State<QuizQuestionsPage> {
  List<QandA> questions = [];
  List<bool> answerVisible = [];

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    try {
      questions = await widget.dbHelper
          .getQandAsForQuiz(widget.quiz.id)
          .then((list) {
        return list.map((item) => QandA.fromMap(item)).toList();
      });
      answerVisible = List<bool>.filled(questions.length, false);
      setState(() {});
    } catch (e) {
      print("Error loading questions: $e");
    }
  }

  void toggleAnswerVisibility(int index) {
    setState(() {
      answerVisible[index] = !answerVisible[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz.name),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          return GestureDetector(
            onTap: () {
              toggleAnswerVisibility(index);
            },
            child: Container(
              color: answerVisible[index] ? Colors.grey : Colors.white,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.question,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Visibility(
                    visible: answerVisible[index],
                    child: Text(
                      question.answer,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
