import 'package:flutter/material.dart';

import '../services/storage.dart';
import 'login_content.dart';
import 'login_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              LoginContent(
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



