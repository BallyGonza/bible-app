import 'package:flutter/material.dart';

/// A Material 3 compliant color picker modal bottom sheet
class CustomModalBottomSheet {
  static void colorPicker(
    BuildContext context,
    void Function(Color) onSelect,
    Color currentColor,
  ) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(28.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Seleccionar color',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const SizedBox(height: 16.0),
              Wrap(
                spacing: 12.0,
                runSpacing: 12.0,
                children: [
                  // Material 3 color palette
                  _buildColorOption(
                      context, Colors.white, onSelect, currentColor),
                  _buildColorOption(
                      context, Colors.grey.shade100, onSelect, currentColor),
                  _buildColorOption(
                      context, Colors.yellow.shade100, onSelect, currentColor),
                  _buildColorOption(
                      context, Colors.green.shade100, onSelect, currentColor),
                  _buildColorOption(
                      context, Colors.blue.shade100, onSelect, currentColor),
                  _buildColorOption(
                      context, Colors.purple.shade100, onSelect, currentColor),
                  _buildColorOption(
                      context, Colors.pink.shade100, onSelect, currentColor),
                  _buildColorOption(
                      context, Colors.orange.shade100, onSelect, currentColor),
                  _buildColorOption(
                      context, Colors.teal.shade100, onSelect, currentColor),
                  _buildColorOption(
                      context, Colors.indigo.shade100, onSelect, currentColor),
                  _buildColorOption(
                      context, Colors.red.shade100, onSelect, currentColor),
                  _buildColorOption(
                      context, Colors.brown.shade100, onSelect, currentColor),
                ],
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancelar'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildColorOption(BuildContext context, Color color,
    void Function(Color) onSelect, Color currentColor) {
  final isSelected = currentColor == color;
  return GestureDetector(
    onTap: () {
      onSelect(color);
      Navigator.of(context).pop();
    },
    child: Container(
      width: 48.0,
      height: 48.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
          width: 2.0,
        ),
      ),
      child: isSelected
          ? Icon(
              Icons.check,
              color:
                  color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
              size: 24.0,
            )
          : null,
    ),
  );
}
