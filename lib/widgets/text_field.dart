import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      required this.hintText,
      required this.secureText,
      required this.labelText})
      : super(key: key);

  String? hintText;
  String? labelText;
  bool? secureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: secureText!,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          gapPadding: 2,
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          gapPadding: 2,
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}
