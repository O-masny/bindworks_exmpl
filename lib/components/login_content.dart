import 'package:flutter/material.dart';

import '../services/storage.dart';
import 'login_field.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
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
          LoginField(
            nameController,
            label: 'Name',
          ),
          LoginField(
            passwordController,
            label: 'Password',
            isObscure: true,
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
