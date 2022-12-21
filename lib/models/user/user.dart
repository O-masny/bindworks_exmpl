import 'package:bindworks_exmpl/models/items/items.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String password;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final Items? items;

  User(
      {this.items,
      required this.id,
      required this.name,
      required this.password});

  Future<void> cacheUser(User userModel) async {
    try {
      final User cacheUser = User(
          items: userModel.items,
          id: userModel.id,
          name: userModel.name,
          password: userModel.password);

      //CACHE_BOX_NAME is any string key
      final userBox = await Hive.openBox('user');
      await userBox.put('userData', cacheUser);
      print(userBox.keys.toString());
    } on Exception {
      throw Exception();
    }
  }

}
