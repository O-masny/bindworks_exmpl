import 'package:flutter/material.dart';

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
