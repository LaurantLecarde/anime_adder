import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sql.dart';

import '../model/animeinfos.dart';

class SqlHelper {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""
     CREATE TABLE passports(
     id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
     image TEXT NOT NULL,
     anime_name TEXT NOT NULL,
     anime_episodes TEXT NOT NULL,
     anime_desc TEXT NOT NULL,
     )
     """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('passport.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }

  static Future<void> saveNewAnime(Passport passport) async {
    final db = await SqlHelper.db();
    db.insert('passports', passport.toJson());
  }

  static Future<List<Passport>> getAllAnimes() async {
    final db = await SqlHelper.db();
    final data = await db.query('passports', orderBy: 'id');
    final List<Passport> passports = [];

    for (var i in data) {
      final passport = Passport.fromJson(i);
      passports.add(passport);
    }
    return passports;
  }

  static Future<void> deleteAnimeInfo(int? id) async {
    final db = await SqlHelper.db();
    await db.delete('passports', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> updateAnimeInfo(int? id, Passport passport) async {
    final db = await SqlHelper.db();
    final data = await db.update('passports', passport.toJson(),
        where: 'id = ?', whereArgs: [id]);
  }
}
