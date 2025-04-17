import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveHandler {
  static Future<Box?> _open(String collection) async {
    try {
      var box = await Hive.openBox(collection);
      return box;
    } on HiveError catch (e) {
      debugPrint('HiveDatabaseHandler.openBox() HiveError: $e');
      return null;
    } catch (e) {
      debugPrint('HiveDatabaseHandler.openBox() Error: $e');
      return null;
    }
  }

  static Future<void> _close(Box? box) async {
    try {
      if (box != null) {
        await box.close();
      }
    } on HiveError catch (e) {
      debugPrint('HiveDatabaseHandler.closeBox() HiveError: $e');
    } catch (e) {
      debugPrint('HiveDatabaseHandler.closeBox() Error: $e');
    }
  }

  static Future<bool> truncate(String collection) async {
    bool res = false;
    Box? box = await _open(collection);
    if (box != null) {
      try {
        await box.deleteFromDisk();
        res = true;
      } on HiveError catch (e) {
        debugPrint('HiveDatabaseHandler.truncate() HiveError: $e');
      } catch (e) {
        debugPrint('HiveDatabaseHandler.truncate() Error: $e');
        return false;
      } finally {
        await _close(box);
      }
    }
    return res;
  }

  // ---------------------------------------------------------------------------------------------------

  static Future<void> create<T>(String collection, dynamic data, {bool replace = false}) async {
    Box? box = await _open(collection);
    if (box != null) {
      if (replace) {
        await box.clear();
      }
      try {
        if (data is T) {
          debugPrint('HIVE CREATE :: Type: ${T.toString()}');
          await box.put((data as dynamic).hashCode.toString(), json.encode((data as dynamic)));
        }
        if (data is List) {
          debugPrint('HIVE CREATE :: type: List<${T.toString()}> \t data_length: ${data.length}');
          for (var item in data) {
            await box.put((item as dynamic).hashCode.toString(), json.encode((item as dynamic)));
          }
        }
      } on HiveError catch (e) {
        debugPrint('HiveDatabaseHandler.create() HiveError: $e');
      } catch (e) {
        debugPrint('HiveDatabaseHandler.create() Error: $e');
      } finally {
        await _close(box);
      }
    }
  }

  static Future<T?> read<T>(String collection, Function(Map<String, dynamic>) fromJsonMethod) async {
    Box? box = await _open(collection);
    if (box != null) {
      try {
        var keys = box.keys;
        if (keys.isNotEmpty) {
          var data = await box.get(keys.first);
          if (data != null) {
            return fromJsonMethod(json.decode(data as String));
          } else {
            debugPrint('HiveDatabaseHandler.read() Error: Koleksiyon boş - $collection');
          }
        } else {
          debugPrint('HiveDatabaseHandler.read() Error: Koleksiyon boş - $collection');
        }
      } on HiveError catch (e) {
        debugPrint('HiveDatabaseHandler.read() HiveError: $e');
      } catch (e) {
        debugPrint('HiveDatabaseHandler.read() Error: $e');
      } finally {
        await _close(box);
      }
    }
    return null;
  }

  static Future<void> update<T>(String collection, String key, T data) async {
    Box? box = await _open(collection);
    if (box != null) {
      try {
        if (box.containsKey(key)) {
          await box.put(key, data);
        } else {
          debugPrint('HiveDatabaseHandler.update() Error: Anahtar bulunamadı - $key');
        }
      } on HiveError catch (e) {
        debugPrint('HiveDatabaseHandler.update() HiveError: $e');
      } catch (e) {
        debugPrint('HiveDatabaseHandler.update() Error: $e');
      } finally {
        await _close(box);
      }
    }
  }

  static Future<void> delete(String collection, dynamic key) async {
    Box? box = await _open(collection);
    if (box != null) {
      try {
        if (box.containsKey(key)) {
          await box.delete(key);
        } else {
          debugPrint('HiveDatabaseHandler.delete() Error: Anahtar bulunamadı - $key');
        }
      } on HiveError catch (e) {
        debugPrint('HiveDatabaseHandler.delete() HiveError: $e');
      } catch (e) {
        debugPrint('HiveDatabaseHandler.delete() Error: $e');
      } finally {
        await _close(box);
      }
    }
  }

  // ---------------------------------------------------------------------------------------------------

  static Future<List<T>> all<T>(String collection, Function(Map<String, dynamic>) fromJsonMethod) async {
    List<T> dataList = [];
    Box? box = await _open(collection);
    if (box != null) {
      try {
        for (var key in box.keys) {
          var data = await box.get(key);
          if (data != null) {
            if (json.decode(data.toString()) is Map<String, dynamic>) {
              dataList.add(fromJsonMethod(json.decode(data.toString())));
            } else {
              debugPrint('HiveDatabaseHandler.getAll() data is not Map<String, dynamic>');
            }
          }
        }
      } on HiveError catch (e) {
        debugPrint('HiveDatabaseHandler.getAll() HiveError: $e');
      } catch (e) {
        debugPrint('HiveDatabaseHandler.getAll() Error: $e');
      } finally {
        await _close(box);
      }
    }
    return dataList;
  }

  static Future<List<T>> paginate<T>(String collection, Function(Map<String, dynamic>) fromJsonMethod, int pageNumber, int pageSize) async {
    List<T> dataList = [];
    Box? box = await _open(collection);
    if (box != null) {
      try {
        final keys = box.keys.toList();
        final startIndex = (pageNumber) * pageSize;
        final endIndex = startIndex + pageSize;

        for (int i = startIndex; i < endIndex && i < keys.length; i++) {
          var key = keys[i];
          var data = await box.get(key);

          if (data != null) {
            if (json.decode(data.toString()) is Map<String, dynamic>) {
              dataList.add(fromJsonMethod(json.decode(data.toString())));
            } else {
              debugPrint('HiveDatabaseHandler.getPaginated() data is not Map<String, dynamic>');
            }
          }
        }
      } on HiveError catch (e) {
        debugPrint('HiveDatabaseHandler.getPaginated() HiveError: $e');
      } catch (e) {
        debugPrint('HiveDatabaseHandler.getPaginated() Error: $e');
      } finally {
        await _close(box);
      }
    }
    return dataList;
  }

  static Future<List<T>> search<T>(String collection, String searchField, String searchText, Function(Map<String, dynamic>) fromJsonMethod) async {
    List<T> dataList = [];
    Box? box = await _open(collection);
    if (box != null) {
      try {
        for (var key in box.keys) {
          var data = await box.get(key);
          if (data != null) {
            if (json.decode(data.toString())[searchField] != null && json.decode(data.toString())[searchField].toString().toLowerCase().contains(searchText.toLowerCase())) {
              dataList.add(fromJsonMethod(json.decode(data.toString())));
            }
          }
        }
      } on HiveError catch (e) {
        debugPrint('HiveDatabaseHandler.search() HiveError: $e');
      } catch (e) {
        debugPrint('HiveDatabaseHandler.search() Error: $e');
      } finally {
        await _close(box);
      }
    }
    return dataList;
  }

  static Future<T?> find<T>(String collection, String key, Function(Map<String, dynamic>) fromJsonMethod) async {
    Box? box = await _open(collection);
    if (box != null) {
      try {
        var data = await box.get(key);
        if (data != null) {
          return fromJsonMethod(json.decode(data as String));
        } else {
          debugPrint('HiveDatabaseHandler.read() Error: Anahtar bulunamadı - $key');
        }
      } on HiveError catch (e) {
        debugPrint('HiveDatabaseHandler.read() HiveError: $e');
      } catch (e) {
        debugPrint('HiveDatabaseHandler.read() Error: $e');
      } finally {
        await _close(box);
      }
    }
    return null;
  }

  static Future<int?> length(String collection) async {
    int? res;
    Box? box = await _open(collection);
    if (box != null) {
      try {
        res = box.length;
      } on HiveError catch (e) {
        debugPrint('HiveDatabaseHandler.getLength() HiveError: $e');
      } catch (e) {
        debugPrint('HiveDatabaseHandler.getLength() Error: $e');
        return -1;
      } finally {
        await _close(box);
      }
    }
    return res;
  }

  static Future<int?> remove(String collection) async {
    int? res;
    Box? box = await _open(collection);
    if (box != null) {
      try {
        res = await box.clear();
      } on HiveError catch (e) {
        debugPrint('HiveDatabaseHandler.remove() HiveError: $e');
      } catch (e) {
        debugPrint('HiveDatabaseHandler.remove() Error: $e');
        return -1;
      } finally {
        await _close(box);
      }
    }
    return res;
  }

  static Future<bool> contains(String collection, dynamic key) async {
    bool contains = false;
    Box? box = await _open(collection);
    if (box != null) {
      try {
        if (box.containsKey(key)) {
          contains = true;
        } else {
          contains = false;
        }
      } on HiveError catch (e) {
        contains = false;
        debugPrint('HiveDatabaseHandler.delete() on $collection HiveError: $e');
      } catch (e) {
        contains = false;
        debugPrint('HiveDatabaseHandler.delete() on $collection Error: $e');
      } finally {
        await _close(box);
      }
    } else {
      contains = false;
    }
    return contains;
  }

  static Future<List<T>> getListFromKeys<T>(String collection, List<String> keyList, Function(Map<String, dynamic>) fromJsonMethod) async {
    List<T> dataList = [];
    Box? box = await _open(collection);
    if (box != null) {
      try {
        for (var key in keyList) {
          var data = await box.get(key);
          if (data != null) {
            if (json.decode(data.toString()) is Map<String, dynamic>) {
              dataList.add(fromJsonMethod(json.decode(data.toString())));
            } else {
              debugPrint('HiveDatabaseHandler.getListFromKeys() on $collection data is not Map<String, dynamic>');
            }
          }
        }
      } on HiveError catch (e) {
        debugPrint('HiveDatabaseHandler.getListFromKeys() on $collection HiveError: $e');
      } catch (e) {
        debugPrint('HiveDatabaseHandler.getListFromKeys() on $collection Error: $e');
      } finally {
        await _close(box);
      }
    }
    return dataList;
  }
}
