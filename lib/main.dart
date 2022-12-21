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
        '/home': (context) => const MyHomePage(),
        '/homepage': (context) => HomePage(item),
        '/addForm': (context) => AddForm(),
      },
      initialRoute: '/',
      theme: ThemeData(backgroundColor: Colors.red, primaryColor: Colors.black),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'PASSWORD LOCKER',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              Icon(
                Icons.lock,
                size: 100,
                color: Colors.white.withOpacity(0.7),
              ),
              LoginTextField(
                '',
                () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const loginHeight = 50.0;

class LoginTextField extends StatefulWidget {
  const LoginTextField(this.hint, this.callback,
      {this.isPassword = false, super.key});

  final bool? isPassword;

  final String? hint;
  final VoidCallback? callback;

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool canComplete =
        passwordController.text.isNotEmpty || nameController.text.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white.withOpacity(0.5),
      ),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(filled: false, hintText: 'Name'),
            textAlign: TextAlign.center,
            cursorColor: Colors.black,
            controller: nameController,
          ),
          TextField(
            obscureText: widget.isPassword ?? false,
            decoration: InputDecoration(filled: false, hintText: 'Password'),
            textAlign: TextAlign.center,
            cursorColor: Colors.black,
            controller: passwordController,
          ),
          IconButton(
            color: canComplete ? Colors.green : Colors.red,
            onPressed: canProceed,
            icon: const Icon(Icons.check),
          )
        ],
      ),
    );
  }

  void canProceed() {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    final password = passwordController.text;
    final name = nameController.text;

    if (!regex.hasMatch(password)) {
      AlertDialog(
          backgroundColor: Colors.red,
          title: Text('Inccorect password'),
          content: Text('Please provide strong password'),
          actions: [
            FlatButton(
              textColor: Colors.black,
              onPressed: () {},
              child: Text('CANCEL'),
            )
          ]);
    } else {
      UserStorage.setLoginName(name);
      UserStorage.setLoginPassword(password);
      Navigator.pushNamed(context, '/homepage');
    }
  }
}
