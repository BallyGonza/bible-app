import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    required this.title,
    required this.content,
    required this.primaryActionTitle,
    required this.onPrimaryPressed,
    super.key,
  }) : hint = null;

  const CustomAlertDialog.textField({
    required this.title,
    required this.hint,
    required this.primaryActionTitle,
    required this.onPrimaryPressed,
    super.key,
  }) : content = null;

  final String title;
  final String? hint;
  final Widget? content;
  final String primaryActionTitle;
  final void Function(String) onPrimaryPressed;

  @override
  Widget build(BuildContext context) {
    // Create our own controller
    final textController = TextEditingController();

    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: content ??
          TextField(
            controller: textController,
            autofocus: true,
            decoration: InputDecoration(hintText: hint),
            maxLines: 2,
          ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            textController.clear();
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            onPrimaryPressed(textController.text);
          },
          child: Text(primaryActionTitle),
        ),
      ],
    );
  }
}
