import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({required this.text});

  String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 25),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          text!,
          style: const TextStyle(
            color: Color(0xff314E69),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
