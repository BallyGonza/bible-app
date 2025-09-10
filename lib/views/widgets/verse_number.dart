import 'package:flutter/material.dart';

class VerseNumber extends StatelessWidget {
  const VerseNumber({
    super.key,
    required this.number,
    required this.style,
    this.visible = true,
  });

  final int number;
  final TextStyle style;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();
    
    return Text(
      '$number ',
      style: style,
    );
  }
}
