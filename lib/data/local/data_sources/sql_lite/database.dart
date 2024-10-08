import 'package:directory_app/data/local/data_sources/sql_lite/translation_dao.dart';
import 'package:directory_app/data/local/models/TranslationModel.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

part 'database.g.dart';

// Avoid name 'Database' for this class because is conflict @Database
@Database(version: 1, entities: [TranslationModel])
abstract class AppDatabase extends FloorDatabase {
  TranslationDao get translationDao;
}

