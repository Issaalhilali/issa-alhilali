import 'package:quizu/models/myscore.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class SqliteService {
  static String databaseName = 'score.db';
  static const String table = 'Scores';

  static Future<Database> initializeDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await createTables(db);
      },
    );
  }

  static Future<void> createTables(Database database) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const timestampType = "TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP";

    await database.execute("""CREATE TABLE IF NOT EXISTS $table(
      id $idType,
      score $textType,
      time $textType,
      createdAt $timestampType
    )""");
  }

  static Future createItem(MyScore score) async {
    final Database db = await initializeDB();
    final id = await db.insert(table, score.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<MyScore>> getItems() async {
    final db = await SqliteService.initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(table);
    return queryResult.map((e) => MyScore.fromJson(e)).toList();
  }
}
