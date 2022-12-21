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
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        suffix: callback != null
            ? GestureDetector(
                onTap: callback ?? () {},
                child: const Icon(
                  Icons.remove_red_eye,
                  color: Colors.white,
                ),
              )
            : const SizedBox(),
        label: Text(
          label ?? 'Password',
          style: const TextStyle(color: Colors.white),
        ),
        hintText: label ?? 'Password',
        hintStyle: const TextStyle(color: Colors.white),
      ),
      obscureText: isObscure ?? false,
      textAlign: TextAlign.center,
      cursorColor: Colors.black,
      controller: controller,
    );
  }
}
