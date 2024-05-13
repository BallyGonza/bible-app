import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar.green({
    required this.text,
    super.key,
  }) : color = Colors.green;
  const CustomSnackBar.red({
    required this.text,
    super.key,
  }) : color = Colors.red;

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: ListTile(
        title: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        trailing: color == Colors.red
            ? Icon(
                Icons.close,
                color: color,
              )
            : Icon(
                Icons.check,
                color: color,
              ),
      ),
    );
  }
}
