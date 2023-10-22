import 'package:meus_gastos/constants/database.dart';
import 'package:meus_gastos/dao/category_dao_impl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> initDataBase() async {
  final path = join(await getDatabasesPath(), databaseName);

  await openDatabase(path, version: 1, onCreate: (db, version) {
    // Tabela categoria
    db.execute('''
      CREATE TABLE ${CategoryDAOImpl.tableName} (
        ${CategoryDAOImpl.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT, 
        ${CategoryDAOImpl.nameColumn} TEXT NOT NULL,
        ${CategoryDAOImpl.iconColumn} TEXT NOT NULL
      )
      ''');

    db.close();
  });
}
