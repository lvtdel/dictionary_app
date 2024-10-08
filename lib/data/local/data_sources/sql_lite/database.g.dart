// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TranslationDao? _translationDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `translation` (`id` INTEGER, `word` TEXT NOT NULL, `translated` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TranslationDao get translationDao {
    return _translationDaoInstance ??=
        _$TranslationDao(database, changeListener);
  }
}

class _$TranslationDao extends TranslationDao {
  _$TranslationDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _translationModelInsertionAdapter = InsertionAdapter(
            database,
            'translation',
            (TranslationModel item) => <String, Object?>{
                  'id': item.id,
                  'word': item.word,
                  'translated': item.translated
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TranslationModel> _translationModelInsertionAdapter;

  @override
  Future<List<TranslationModel>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM translation',
        mapper: (Map<String, Object?> row) => TranslationModel(
            row['id'] as int?,
            row['word'] as String,
            row['translated'] as String));
  }

  @override
  Future<List<TranslationModel>> findByWord(String word) async {
    return _queryAdapter.queryList(
        'SELECT * FROM translation WHERE word LIKE ?1',
        mapper: (Map<String, Object?> row) => TranslationModel(
            row['id'] as int?,
            row['word'] as String,
            row['translated'] as String),
        arguments: [word]);
  }

  @override
  Future<void> removeTranslationModel(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM translation WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<int> insertTranslationModel(TranslationModel translationModel) {
    return _translationModelInsertionAdapter.insertAndReturnId(
        translationModel, OnConflictStrategy.abort);
  }
}
