// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorBasisDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$BasisDatabaseBuilder databaseBuilder(String name) =>
      _$BasisDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$BasisDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$BasisDatabaseBuilder(null);
}

class _$BasisDatabaseBuilder {
  _$BasisDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$BasisDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$BasisDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<BasisDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$BasisDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$BasisDatabase extends BasisDatabase {
  _$BasisDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BasisDao _basisDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
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
            'CREATE TABLE IF NOT EXISTS `PriceEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `price` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BasisDao get basisDao {
    return _basisDaoInstance ??= _$BasisDao(database, changeListener);
  }
}

class _$BasisDao extends BasisDao {
  _$BasisDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _priceEntityInsertionAdapter = InsertionAdapter(
            database,
            'PriceEntity',
            (PriceEntity item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'price': item.price
                }),
        _priceEntityDeletionAdapter = DeletionAdapter(
            database,
            'PriceEntity',
            ['id'],
            (PriceEntity item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'price': item.price
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PriceEntity> _priceEntityInsertionAdapter;

  final DeletionAdapter<PriceEntity> _priceEntityDeletionAdapter;

  @override
  Future<List<PriceEntity>> findAllPrice() async {
    return _queryAdapter.queryList('SELECT * FROM PriceEntity',
        mapper: (Map<String, dynamic> row) => PriceEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            price: row['price'] as String));
  }

  @override
  Future<void> insertPrice(PriceEntity price) async {
    await _priceEntityInsertionAdapter.insert(price, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePrice(PriceEntity price) async {
    await _priceEntityDeletionAdapter.delete(price);
  }
}
