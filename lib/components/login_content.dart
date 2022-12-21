import 'package:bindworks_exmpl/components/submit_button.dart';
import 'package:flutter/material.dart';

import '../services/modal_dialog.dart';
import '../services/storage.dart';
import 'login_field.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({this.args, super.key});

  final LoginArguments? args;

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  bool forgottenPassword = false;

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
  Widget build(BuildContext context) => !forgottenPassword
      ? Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
                onTap: () => setState(() {
                      forgottenPassword = !forgottenPassword;
                    }),
                child: const Text(
                  'Lost your password?',
                  style: TextStyle(color: Colors.white),
                )),
            const SizedBox(
              height: 30,
            ),
            SubmitButton(
              title: 'LOGIN',
              callback: canProceed,
            )
          ],
        )
      : Column(
          children: [
            LoginField(
              nameController,
              label: 'Name',
            ),
            const SizedBox(
              height: 40,
            ),
            SubmitButton(
              title: 'LOGIN',
              callback: () => canProceed(lostPassword: true),
            )
          ],
        );

  void canProceed({bool lostPassword = false}) {
    if (lostPassword) {}
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    final password = passwordController.text;
    final name = nameController.text;

    if (!regex.hasMatch(password)) {
      ModalDialog.showAlert(context, AlertType.WRONG);
    } else {
      UserStorage.setLoginName(name);
      UserStorage.setLoginPassword(password);
      Navigator.pushNamed(context, '/homepage');
    }
  }
}

