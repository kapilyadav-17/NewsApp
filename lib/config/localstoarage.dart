import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../modals/news.dart';

class DbManager {

  static Database? _database;
  static Future openDb() async {
    _database = await openDatabase(join(await getDatabasesPath(), "Newsapp.db"),
        version: 1, onCreate: (Database db, int version) async {
          await db.execute(
            "CREATE TABLE news(title TEXT , description TEXT,imageUrl TEXT, publishedAt TEXT PRIMARY KEY,source TEXT)",
          );
        });
    //return _database;
  }
  static Future insertModel(News model) async {
    await openDb();
    await _database!.insert('news', News.toJson(model));
    //wh return await
  }
  static Future<List<News>> getNewsList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database!.query('news');

    return List.generate(maps.length, (i) {
      return News(
          title: maps[i]['title'],
          description: maps[i]['description'],
          source: maps[i]['source'],
          publishedAt: maps[i]['publishedAt'],
          imageUrl: maps[i]['imageUrl'],
      );
    });
    // return maps
    //     .map((e) => Model(
    //         id: e["id"], fruitName: e["fruitName"], quantity: e["quantity"]))
    //     .toList();
  }

  static Future<int> updateModel(News model) async {
    await openDb();
    return await _database!.update('news', News.toJson(model),
        where: "id = ?", whereArgs: [model.title]);
  }


}