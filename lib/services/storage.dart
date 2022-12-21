import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

  static Future setLoginPassword(String loginPassword) async =>
      await _storage.write(key: _loginPassword, value: loginPassword);

  static Future setLoginName(String loginName) async =>
      await _storage.write(key: _loginName, value: loginName);
}
