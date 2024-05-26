import 'package:gerenciamento_de_residuos/JsonModels/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final databaseName = "notes.db";
  String noteTable =
      "CREATE TABLE notes (noteId INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT NOT NULL, location TEXT NOT NULL, weight DOUBLE NOT NULL, createdAt TEXT DEFAULT CURRENT_TIMESTAMP)";

  //Now we must create our user table into our sqlite db

  //We are done in this section

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(noteTable);
    });
  }

  //Search Method
  Future<List<NoteModel>> searchNotes(String keyword) async {
    final Database db = await initDB();
    List<Map<String, Object?>> searchResult = await db
        .rawQuery("select * from notes where noteTitle LIKE ?", ["%$keyword%"]);
    return searchResult.map((e) => NoteModel.fromMap(e)).toList();
  }

  //CRUD Methods

  Future<int> createNote(NoteModel note) async {
    final Database db = await initDB();
    return db.insert('notes', note.toMap());
  }

  Future<List<NoteModel>> getNotes() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('notes');
    return result.map((e) => NoteModel.fromMap(e)).toList();
  }

  Future<int> deleteNote(int id) async {
    final Database db = await initDB();
    return db.delete('notes', where: 'noteId = ?', whereArgs: [id]);
  }

  Future<int> updateNote(type, location, weight, noteId) async {
    final Database db = await initDB();
    return db.rawUpdate(
        'update notes set type = ?, location = ?, weight = ? where noteId = ?',
        [type, location, weight, noteId]);
  }

  Future<double> getEntryWeightSum() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('notes');
    var array = result.map((e) => NoteModel.fromMap(e)).toList();
    double sum = array.fold(0.0, (sum, item) => sum + item.weight);
    return sum;
  }
}
