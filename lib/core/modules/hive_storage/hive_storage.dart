import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HiveStorage {
  HiveStorage(this._hive);

  final HiveInterface _hive;

  Future<void> putAll<T>(List<T> values, int skip) async {
    final box = await _openOrGetBox<T>();
    for (var i = 0; i < values.length; i++) {
      await box.put(skip + i, values[i]);
    }
  }

  Future<List<T>> getAll<T>() async {
    final box = await _openOrGetBox<T>();
    return box.values.toList();
  }

  Future<void> put<T>(String key, T value) async {
    final box = await _openOrGetBox<T>();
    await box.put(key, value);
  }

  Future<T?> get<T>(String key) async {
    final box = await _openOrGetBox<T>();
    var value = box.get(key);
    return value;
  }

  Future<void> delete<T>(String key) async {
    final box = await _openOrGetBox<T>();
    await box.delete(key);
  }

  Future<void> clear<T>() async {
    final box = await _openOrGetBox<T>();
    await box.clear();
  }

  Future<void> clearAll() async {
    await _hive.deleteFromDisk();
  }

  Future<Box<T>> _openOrGetBox<T>() async {
    var boxName = T.toString();
    if (T == dynamic) {
      boxName = 'default';
    }
    return await _hive.openBox<T>(boxName);
  }
}
