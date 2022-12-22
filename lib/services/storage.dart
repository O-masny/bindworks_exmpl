import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/adapters.dart';

import '../models/items/items.dart';
import '../models/user/user.dart';

class UserStorage {
  static const _storage = FlutterSecureStorage();
  static const _url = 'url';
  static const _name = 'name';
  static const _password = 'password';

  static const _loginName = 'l_name';
  static const _loginPassword = 'l_password';

  static Future setUrl(String url) async =>
      await _storage.write(key: _url, value: url);

  static Future setName(String name) async =>
      await _storage.write(key: _name, value: name);

  static Future setPassword(String password) async =>
      await _storage.write(key: _password, value: password);

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

  void addUserToList(Items item) {
    items.add(item);
  }

  Future<List<Items>> getPersistedItems({int? id}) async {
    try {
      final userBox = await Hive.openBox('items/$id');
      items = userBox.values.cast<Items>().toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return items;
  }

  Future<User> getPersistedUser() async {
    try {
      final userBox = await Hive.openBox('user');
      final User cacheUser = userBox.get('userData') as User;

      await userBox.close();

      return cacheUser;
    } on Exception {
      throw Exception();
    }
  }

  List<Items> items = [];

  List<Items> get itemsList => items;
}
