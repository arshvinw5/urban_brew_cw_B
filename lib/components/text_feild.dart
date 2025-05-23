import 'package:flutter/material.dart';

class ReuseableTextFelid extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  const ReuseableTextFelid(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          hintText: hintText),
    );
  }
}
