import 'package:bindworks_exmpl/components/submit_button.dart';
import 'package:flutter/material.dart';
import '../../../models/arguments/login_args.dart';
import '../../../models/user/user.dart';
import '../../../services/modal_dialog.dart';
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
                  'Have an account?',
                  style: TextStyle(color: Colors.white),
                )),
            const SizedBox(
              height: 30,
            ),
            SubmitButton(
              title: 'Register',
              callback: () => canProceed(context),
            )
          ],
        )
      : Column(
          children: [
            const Text(
              'Insert password',
              style: TextStyle(color: Colors.white),
            ),
            LoginField(
              passwordController,
              label: 'Password',
            ),
            const SizedBox(
              height: 40,
            ),
            SubmitButton(
              title: 'LOGIN',
              callback: () => canProceed(context, login: true).then(
                  (value) => Navigator.pushNamed(context, '/homepage'),
                  onError: () =>
                      ModalDialog.showAlert(context, AlertType.WRONG)),
            )
          ],
        );

  Future<void> canProceed(BuildContext context, {bool login = false}) async {
    UserStorage storage = UserStorage();
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    final password = passwordController.text;
    final name = nameController.text;
    User user = await storage.getPersistedUser();
    if (!regex.hasMatch(password) || name.isEmpty) {
      ModalDialog.showAlert(context, AlertType.WRONG);
      return;
    }
    if (login) {
      if (password == user.password) {
        return;
      } else {
        ModalDialog.showAlert(context, AlertType.WRONG);
        return;
      }
    }
    User registerUser = User(id: 1, password: password, name: name);
    await user.cacheUser(registerUser);
    await storage.saveUserPassword(password);
    Navigator.pushNamed(context, '/homepage');
  }
}
