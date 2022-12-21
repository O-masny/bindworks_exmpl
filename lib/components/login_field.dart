import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  const LoginField(this.controller,
      {this.label, this.isObscure = false, this.callback, Key? key})
      : super(key: key);
  final TextEditingController controller;
  final String? label;
  final bool? isObscure;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        suffix: callback != null
            ? GestureDetector(
                onTap: callback ?? () {},
                child: Icon(
                  Icons.remove_red_eye,
                  color: Colors.white,
                ),
              )
            : SizedBox(),
        label: Text(
          label ?? 'Password',
          style: const TextStyle(color: Colors.white),
        ),
        hintText: label ?? 'Password',
        alignLabelWithHint: true,
        hintStyle: const TextStyle(color: Colors.white),
      ),
      obscureText: isObscure ?? false,
      textAlign: TextAlign.center,
      cursorColor: Colors.black,
      controller: controller,
    );
  }
}
