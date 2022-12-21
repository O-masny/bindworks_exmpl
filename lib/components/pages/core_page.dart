import 'package:flutter/material.dart';

class CorePage extends StatelessWidget {
  const CorePage(this.widget,
      {this.title, this.floatingActionButton, this.leading, Key? key})
      : super(key: key);
  final String? title;
  final Widget? leading;
  final Widget? floatingActionButton;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: floatingActionButton,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          title ?? 'Password Locker',
          style: const TextStyle(color: Colors.white),
        ),
        leading: leading,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: widget,
        ),
      ),
    );
  }
}
