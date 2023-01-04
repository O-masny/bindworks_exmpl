import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import '../models/items/items.dart';

class ItemStorage {
/*
  Future<void> saveUserPassword(String password) async {
    try {
      print(password);
      final secureKey = Hive.generateSecureKey();
      final encryptedBox =
          await Hive.openBox('login', encryptionKey: secureKey);
      await encryptedBox.put('password', password);
      print(encryptedBox.values.toString());

      await _storage.write(
        key: 'en_password',
        value: json.encode(secureKey),
      );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
*/
  Future<void> cacheItem(Items items, {int? id}) async {
    try {
      final Items cacheItem =
          Items(url: items.url, name: items.name, password: items.password);
      final userBox = await Hive.openBox('items');
      userBox.add(cacheItem);

      print(cacheItem.name);
      print(cacheItem.url);
      print(cacheItem.password);
    } on Exception {
      throw Exception();
    }
  }

  void addItemToList(Items item) {
    items.add(item);
  }

  Future<List<Items>> getPersistedItems({int? id}) async {
    try {
      final userBox = await Hive.openBox('items');
      items = userBox.values.cast<Items>().toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return items;
  }

  List<Items> items = [];

  List<Items> get itemsList => items;
}
