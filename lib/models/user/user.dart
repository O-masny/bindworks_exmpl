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
  final bool isLogged;
  @HiveField(3)
  final Items? items;

  User( this.items,{required this.id, required this.password, required this.isLogged});
}
