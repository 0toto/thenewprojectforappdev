import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DataBaseHelper {
  static const _databaseName = "myDatabase2.db";
  static const _databaseVersion = 1;

  static const table = "My_Table";
  static const columnId = "_id";
  static const columnName = "_name";
  static const columnPassword = "_password";

  static const quizTable = "quiztable";
  static const columnIdQuiz = "_quizId";
  static const columnNameQuiz = "_quizName";

  static const qandaTable = "QandA";
  static const columnIdQandA = "_id";
  static const columnQuestion = "_question";
  static const columnAnswer = "_answer";
  static const columnQuizId = "quiz_id";

  late Database _db;

  Future<void> init() async {
    try {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, _databaseName);
      _db = await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate,
      );
    } catch (e) {
      print("Error initializing database: $e");
      rethrow;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnPassword TEXT NOT NULL
      )
      ''');

      await db.execute('''
      CREATE TABLE $quizTable (
        $columnIdQuiz INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        $columnNameQuiz TEXT
      )
      ''');

      await db.execute('''
      CREATE TABLE $qandaTable (
        $columnIdQandA INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnQuestion TEXT,
        $columnAnswer TEXT,
        $columnQuizId INTEGER,
        FOREIGN KEY ($columnQuizId) REFERENCES $quizTable($columnId)
      )
      ''');
    } catch (e) {
      print("Error creating database tables: $e");
      rethrow;
    }
  }

  Future<int> insert(Map<String, dynamic> row) async {
    try {
      return await _db.insert(table, row);
    } catch (e) {
      print("Error inserting row: $e");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await _db.query(table);
  }

  Future<int> queryRowCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $table');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<int> update(Map<String, dynamic> row) async {
    int id = row[columnId];
    return await _db.update(
      table,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    return await _db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> insertQuiz(String quizName) async {
    return await _db.insert(
      quizTable,
      {columnNameQuiz: quizName},
    );
  }

  Future<void> deleteAllTables() async {
    try {
      await _db.delete(table);
      await _db.delete(quizTable);
      await _db.delete(qandaTable);
    } catch (e) {
      print("Error deleting tables: $e");
      rethrow;
    }
  }

  Future<int> insertQandA(int quizId, String question, String answer) async {
    return await _db.insert(
      qandaTable,
      {
        columnQuestion: question,
        columnAnswer: answer,
        columnQuizId: quizId,
      },
    );
  }

  Future<List<Map<String, dynamic>>> getAllQuizzes() async {
    return await _db.query(quizTable);
  }

  Future<List<Map<String, dynamic>>> getQandAsForQuiz(int quizId) async {
    return await _db.query(qandaTable, where: '$columnQuizId = ?', whereArgs: [quizId]);
  }

  Future<void> close() async {
    try {
      await _db.close();
    } catch (e) {
      print("Error closing database: $e");
      rethrow;
    }
  }
}

