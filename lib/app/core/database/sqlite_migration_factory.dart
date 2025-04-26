
import 'package:cuidapet_mobile/app/core/database/migrations/migration_v1.dart';
import 'migrations/migration.dart';

class SqliteMigrationFactory {
  List<Migration> getCreateMigrations() => [
    MigrationV1(),
  ];
  
  List<Migration> getUpdateMigrations(int version){
    return [];
  }
}