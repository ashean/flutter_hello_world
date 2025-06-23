// These imports are necessary to use Drift.
import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// This part directive tells Drift where to generate the code.
part 'database.g.dart';

// This class defines our "Todos" table.
// Drift will generate a class called "Todo" to represent a row in this table.
class Todos extends Table {
  // id will be the primary key, and it will auto-increment.
  IntColumn get id => integer().autoIncrement()();

  // The title of the todo item.
  TextColumn get title => text().withLength(min: 1, max: 100)();

  // A boolean to check if the todo is completed. Defaults to false.
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
}

// This is the main database class. The @DriftDatabase annotation tells Drift
// what tables to include.
@DriftDatabase(tables: [Todos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

// This private function is used to open the connection to the database file.
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
