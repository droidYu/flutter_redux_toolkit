import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseService {
  static const int _databaseVersion = 1;

  DatabaseService._privateConstructor();

  static final DatabaseService instance = DatabaseService._privateConstructor();

  Future<sql.Database?> getDB() async {
    await this.checkDatabase();
    return _database;
  }

  static sql.Database? _database;
  Future<void> openDatabase(String databaseName) async {
    final String databasePath = await sql.getDatabasesPath();
    print(databasePath);
    final String dbPath = path.join(databasePath, databaseName);
    _database = await sql.openDatabase(dbPath, version: _databaseVersion,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Todos (_id INTEGER PRIMARY KEY, title TEXT, description TEXT)');
    });
  }

  Future<void> checkDatabase() async {
    if (_database == null) return openDatabase('todos.db');
  }
}
