import 'package:bindworks_exmpl/components/pages/home_page.dart';
import 'package:bindworks_exmpl/components/submit_button.dart';
import 'package:flutter/material.dart';
import '../../../models/arguments/home_args.dart';
import '../../../models/arguments/login_args.dart';
import '../../../models/user/user.dart';
import '../../../services/modal_dialog.dart';
import '../../../services/secure_storage.dart';
import '../../../services/storage.dart';
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
  static RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final name = await UserSecureStorage.getUsername() ?? '';
    setState(() {
      nameController.text = name;
    });
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
                  'Register here',
                  style: TextStyle(color: Colors.white),
                )),
            const SizedBox(
              height: 30,
            ),
            SubmitButton(
              title: 'Login',
              callback: () => canProceed(context),
            )
          ],
        )
      : Column(
          children: [
            GestureDetector(
              onTap: () => setState(() {
                forgottenPassword = !forgottenPassword;
              }),
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
            LoginField(
              nameController,
              label: 'Name',
            ),
            LoginField(
              passwordController,
              label: 'Password',
            ),
            const SizedBox(
              height: 40,
            ),
            SubmitButton(
              title: 'Register',
              callback: () => canProceed(context, login: true),
            )
          ],
        );

  Future<void> canProceed(BuildContext context, {bool login = false}) async {
    final password = passwordController.text;
    final name = nameController.text;

    if (!regex.hasMatch(password) || name.isEmpty) {
      ModalDialog.showAlert(context, AlertType.WRONG);
      return;
    }
    String? savedName = await UserSecureStorage.getUsername() ?? '';
    String? savedPass = await UserSecureStorage.getPassword() ?? '';

    if (login && savedName == name && savedPass == password) {
      goToHomePage();
    } else {
      ModalDialog.showAlert(context, AlertType.WRONG);
    }
    await UserSecureStorage.setUsername(name);

    await UserSecureStorage.setPassword(password);

/*
    User? user = await storage.getPersistedUser();
    if (login && user?.password != null) {
      if (password == user!.password && user.name == name) {
        return;
      } else {
        ModalDialog.showAlert(context, AlertType.WRONG);
      }
    }

    if (user == null) {
      User registerUser = User(id: 1, password: password, name: name);
      await user?.cacheUser(registerUser);

    }  */
  }

  void goToHomePage() => Navigator.pushNamed(
        context,
        '/homepage',
        arguments: HomePageArgs(isFromLogin: true),
      );
}
