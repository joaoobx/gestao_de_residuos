import 'package:gerenciamento_de_residuos/JsonModels/entry_model.dart';
import 'package:gerenciamento_de_residuos/JsonModels/exit_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final databaseName = "entries.db";
  String entriesTable =
      "CREATE TABLE entries (entryId INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT NOT NULL, location TEXT NOT NULL, weight DOUBLE NOT NULL, createdAt TEXT DEFAULT CURRENT_TIMESTAMP)";
  String exitsTable =
      "CREATE TABLE exits (exitId INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT NOT NULL, location TEXT NOT NULL, weight DOUBLE NOT NULL, supplier TEXT NOT NULL, mtr TEXT NOT NULL, cdf TEXT NOT NULL, revenue DOUBLE NOT NULL, cost DOUBLE NOT NULL, createdAt TEXT DEFAULT CURRENT_TIMESTAMP)";

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(entriesTable);
      await db.execute(exitsTable);
    });
  }
  

  Future<int> createEntry(EntryModel entry) async {
    final Database db = await initDB();
    return db.insert('entries', entry.toMap());
  }

  Future<int> createExit(ExitModel exit) async {
    final Database db = await initDB();
    return db.insert('exits', exit.toMap());
  }

  Future<List<EntryModel>> getEntries() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('entries');
    return result.map((e) => EntryModel.fromMap(e)).toList();
  }

  Future<List<ExitModel>> getExits() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('exits');
    return result.map((e) => ExitModel.fromMap(e)).toList();
  }

  Future<int> deleteEntry(int id) async {
    final Database db = await initDB();
    return db.delete('entries', where: 'entryId = ?', whereArgs: [id]);
  }

  Future<int> deleteExit(int id) async {
    final Database db = await initDB();
    return db.delete('exits', where: 'exitId = ?', whereArgs: [id]);
  }

  Future<int> updateEntry(type, location, weight, noteId) async {
    final Database db = await initDB();
    return db.rawUpdate(
        'update entries set type = ?, location = ?, weight = ? where entryId = ?',
        [type, location, weight, noteId]);
  }

  Future<int> updateExit(type, location, weight, supplier, mtr, cdf, revenue, cost, noteId) async {
    final Database db = await initDB();
    return db.rawUpdate(
        'update entries set type = ?, location = ?, weight = ?, supplier = ?, mtr = ?, cdf = ?, revenue = ?, cost = ?, where exitId = ?',
        [type, location, weight, supplier, mtr, cdf, revenue, cost, noteId]);
  }

  Future<double> getEntryWeightSum() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('entries');
    var array = result.map((e) => EntryModel.fromMap(e)).toList();
    double sum = array.fold(0.0, (sum, item) => sum + item.weight);
    return sum;
  }

  Future<double> getExitWeightSum() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('exits');
    var array = result.map((e) => EntryModel.fromMap(e)).toList();
    double sum = array.fold(0.0, (sum, item) => sum + item.weight);
    return sum;
  }
}
