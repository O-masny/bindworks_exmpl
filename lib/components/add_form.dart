import 'package:bindworks_exmpl/components/submit_button.dart';
import 'package:bindworks_exmpl/models/items/items.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bindworks_exmpl/services/modal_dialog.dart';
import '../services/storage.dart';
import 'pages/login/login_field.dart';

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

  Future<void> canProceed() async {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    final password = passwordController.text;
    final name = nameController.text;
    final url = urlController.text;

    if (!regex.hasMatch(password)) {
      ModalDialog.showAlert(context, AlertType.WEAK);
    } else {
      Items item = Items(url: url, name: name, password: password);
      await UserStorage().cacheItem(item).then(
            (value) => Navigator.pushNamed(context, '/homepage'),
          );
    }
  }
}
