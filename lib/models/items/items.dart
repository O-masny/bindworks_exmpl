import 'package:hive/hive.dart';

part 'items.g.dart';

@HiveType(typeId: 2)
class Items extends HiveObject {
  @HiveField(0)
  final String url;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String password;

  Items({required this.url, required this.name, required this.password});



}
