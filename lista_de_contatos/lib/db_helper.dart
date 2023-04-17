import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static String CREATE_CONTACTS_TABLE_SCRIPT =
      "CREATE TABLE contatos(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nome TEXT, email TEXT, createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)";

  static Future<sql.Database> db() async {
    var dataBasePath = await sql.getDatabasesPath();

    String path = join(dataBasePath, 'banco.db');

    var bd = await sql.openDatabase(path, version: 1,
        onCreate: (db, versaoRecente) async {
      await db.execute(CREATE_CONTACTS_TABLE_SCRIPT);
    });

    print('Banco: ' + bd.isOpen.toString());

    return bd;
  }

  static Future<int> createContato(String nome, String email) async {
    final db = await SQLHelper.db();

    final data = {'nome': nome, 'email': email};
    final id = await db.insert('contatos', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllContatos() async {
    final db = await SQLHelper.db();

    return db.query('contatos', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getContatoByName(
      String nome) async {
    final db = await SQLHelper.db();

    return db.query('contatos', where: "nome = ?", whereArgs: [nome]);
  }

  static Future<List<Map<String, dynamic>>> getContatoById(int id) async {
    final db = await SQLHelper.db();

    return db.query('contatos', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateContato(int id, String nome, String email) async {
    final db = await SQLHelper.db();

    final data = {
      'nome': nome,
      'email': email,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('contatos', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteContato(int id) async {
    final db = await SQLHelper.db();

    try {
      await db.delete('contatos', where: "id = ?", whereArgs: [id]);
    } catch (e) {}
  }
}
