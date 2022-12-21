import 'package:flutter/material.dart';

enum AlertType { WEAK, WRONG }

String title(AlertType type) =>
    type == AlertType.WEAK ? 'Weak password' : 'Wrong Password';

String content(AlertType type) => type == AlertType.WEAK
    ? 'Please provide strong password'
    : 'Please provide correct password';

class ModalDialog {
  static void showAlert(BuildContext ctx, AlertType type) {
    showDialog<String>(
      context: ctx,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(title(type)),
        content: Text(content(type)),
      ),
    );
  }
}
