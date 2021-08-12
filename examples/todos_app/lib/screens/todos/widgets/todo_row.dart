import 'package:flutter/material.dart';

class TodoRow {
  final String title;
  final String description;

  TodoRow(this.title, this.description);

  Widget buildTitle(BuildContext context) => Text(title);

  Widget buildSubtitle(BuildContext context) => Text(description);

  Widget buildButton(BuildContext context) => TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        onPressed: () {},
        child: const Text('TextButton'),
      );
}
