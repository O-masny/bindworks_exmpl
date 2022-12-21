import 'dart:math';
import 'package:bindworks_exmpl/components/add_form.dart';
import 'package:bindworks_exmpl/models/user/user.dart';
import 'package:bindworks_exmpl/services/storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bindworks_exmpl/components/detail_page.dart';
import 'package:bindworks_exmpl/models/items/items.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'components/home_page.dart';
import 'components/login_page.dart';

late Box box;

void main() async {
  // await Hive.initFlutter();
  // box = await Hive.openBox('box');

// box.put('name', 'a');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Items item = Items(url: '', password: '', name: '');
    return MaterialApp(
      title: 'Password Keeper',
      routes: {
        '/detail': (context) => const DetailPage(),
        '/home': (context) => const LoginPage(),
        '/homepage': (context) => HomePage(item),
        '/addForm': (context) => const AddForm(),
      },
      initialRoute: '/',
      theme: ThemeData(backgroundColor: Colors.red, primaryColor: Colors.black),
      home: const LoginPage(),
    );
  }
}
