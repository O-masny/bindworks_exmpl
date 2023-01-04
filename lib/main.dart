import 'package:bindworks_exmpl/components/add_form.dart';
import 'package:bindworks_exmpl/models/user/user.dart';
import 'package:bindworks_exmpl/components/pages/detail_page.dart';
import 'package:bindworks_exmpl/models/items/items.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'components/pages/home_page.dart';
import 'components/pages/login/login_page.dart';

late Box? box;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(UserAdapter());
  }
  await Hive.deleteFromDisk();
  await Hive.deleteBoxFromDisk('items');
  await Hive.deleteBoxFromDisk('user');
  await Hive.deleteBoxFromDisk('userData');
  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(ItemsAdapter());
  }

  box = await Hive.openBox('logindata');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Keeper',
      routes: {
        '/detail': (context) => const DetailPage(),
        '/loginPage': (context) => const LoginPage(),
        '/homepage': (context) => const HomePage(),
        '/addForm': (context) => const AddForm(),
      },
      initialRoute: '/',
      theme: ThemeData(primaryColor: Colors.black),
      home: box?.get('isLogged', defaultValue: false)
          ? const HomePage()
          : const LoginPage(),
    );
  }
}
