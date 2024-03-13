import 'package:bible_app/data/data.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    required this.title,
    required this.description,
    required this.rightButtonText,
    required this.onRightButtonPressed,
    super.key,
  });

  final String title;
  final String description;
  final String rightButtonText;
  final VoidCallback onRightButtonPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: appColorDarker,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      content: Text(
        description,
        style: const TextStyle(color: Colors.white),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () {
            onRightButtonPressed();
            Navigator.pop(context);
          },
          child:
              Text(rightButtonText, style: const TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
