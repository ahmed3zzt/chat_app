import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      required this.secureText,
      required this.labelText,
      this.onchange})
      : super(key: key);

  String? labelText;
  bool? secureText;
  Function(String)? onchange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Field Is Required";
        }
      },
      onChanged: onchange,
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
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}
