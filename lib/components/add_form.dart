import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'login_field.dart';

class AddForm extends StatefulWidget {
  const AddForm({Key? key}) : super(key: key);

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final urlController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  bool visibilityToggle = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    urlController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool canComplete = passwordController.text.isNotEmpty ||
        nameController.text.isNotEmpty ||
        urlController.text.isNotEmpty;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Password Locker'),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.white.withOpacity(0.5),
                  child: const Text(
                    'Add new password with URL and NAME',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ),
              LoginField(
                urlController,
                label: 'Url',
              ),
              LoginField(
                nameController,
                label: 'Name',
              ),
              LoginField(
                passwordController,
                isObscure: visibilityToggle,
                label: 'Password',
                callback: () => setState(() {
                  visibilityToggle = !visibilityToggle;
                }),
              ),
              SubmitButton(
                title: 'Save password',
                callback: canProceed,
              )
            ],
          ),
        ),
      ),
    );
  }

  void toggle() {}

  void canProceed() {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    final password = passwordController.text;
    final name = nameController.text;
    final url = urlController.text;

    if (!regex.hasMatch(password)) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => const AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Weak password'),
          content: Text('Please provide strong password'),
        ),
      );
    } else {

      Navigator.pushNamed(context, '/homepage');
    }
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({this.title = '', this.callback, Key? key})
      : super(key: key);
  final String? title;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback ?? () {},
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        alignment: Alignment.center,
        child: Text(
          title ?? 'Add password',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
