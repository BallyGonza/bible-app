import 'package:bible_app/core/core.dart';
import 'package:flutter/material.dart';

/// A Material 3 compliant color picker modal bottom sheet
class CustomModalBottomSheet {
  static void colorPicker(
    BuildContext context,
    void Function(Color) onSelect,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.8,
          builder: (context, scrollController) => Container(
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(28)),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, -10),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header with close button
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: colorScheme.outlineVariant.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Seleccionar Color',
                        style: textTheme.titleLarge?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.close,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: colorScheme.surfaceContainerHighest,
                        ),
                      ),
                    ],
                  ),
                ),
                // Color grid
                Expanded(
                  child: GridView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(24),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1,
                    ),
                    itemCount: colors.length,
                    itemBuilder: (context, index) {
                      final color = colors[index];
                      return _ColorOption(
                        color: color,
                        onTap: () {
                          onSelect(color);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Individual color option widget with Material 3 styling
class _ColorOption extends StatefulWidget {
  const _ColorOption({
    required this.color,
    required this.onTap,
  });

  final Color color;
  final VoidCallback onTap;

  @override
  State<_ColorOption> createState() => _ColorOptionState();
}

class _ColorOptionState extends State<_ColorOption>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: colorScheme.outline.withOpacity(0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: widget.color == Colors.white
                    ? Icon(
                        Icons.check,
                        color: colorScheme.onSurface,
                        size: 24,
                      )
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}
