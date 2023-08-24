import 'dart:async';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';

class HiveCacheManager implements CacheManager {
  HiveCacheManager() {
    initDB();
  }

  late final Box globalBox;
  late final Completer<void> initTasksCompleter;

  Future<void> initDB() async {
    initTasksCompleter = Completer();

    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    globalBox = await Hive.openBox<String>('global');

    initTasksCompleter.complete();
  }

  @override
  Future<String?> getJsonData(String key, {String? table}) async {
    await initTasksCompleter.future;
    final box = table == null ? globalBox : await getBox(table);
    final String? data = box.get(key);

    if (data == 'null' || (data?.isEmpty ?? true)) {
      return null;
    }

    return box.get(key);
  }

  @override
  Future<void> saveJsonData(String key, String value, {String? table}) async {
    await initTasksCompleter.future;
    final box = table == null ? globalBox : await getBox(table);

    if (value != 'null' || value.isNotEmpty) {
      await box.put(key, value);
    }
  }

  @override
  Future<Map<String, String>> getTableEntries(String tableKey) async {
    await initTasksCompleter.future;
    final box = await getBox(tableKey);

    return Map.fromEntries(
      box.toMap().entries.map((e) => MapEntry(e.key.toString(), e.value)),
    );
  }

  Future<Box<String>> getBox(String tableName) async {
    if (Hive.isBoxOpen(tableName)) {
      return Hive.box<String>(tableName);
    } else {
      return Hive.openBox<String>(tableName);
    }
  }
}
