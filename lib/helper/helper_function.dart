import 'package:flutter/material.dart';

void displayMessageToUser(
    String heading, String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        heading,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      content: Text(
        message,
        style: TextStyle(fontSize: 26.0),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Okay"),
        ),
      ],
    ),
  );
}
