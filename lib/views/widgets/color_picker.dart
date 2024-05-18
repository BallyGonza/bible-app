import 'package:bible_app/data/data.dart';
import 'package:flutter/material.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({
    required this.onSelect,
    super.key,
  });

  final void Function(Color) onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height * 0.54,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
        ),
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              onSelect(colors[index]);
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colors[index],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
      ),
    );
  }
}
