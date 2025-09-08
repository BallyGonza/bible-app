import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.controller,
    this.focusNode,
    this.autoFocus = false,
  });

  final String hintText;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SearchBar(
        onTapOutside: (_) => focusNode?.unfocus(),
        focusNode: focusNode,
        autoFocus: autoFocus,
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 16),
        ),
        controller: controller,
        hintText: hintText,
        hintStyle: MaterialStateProperty.all(
          theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        textStyle: MaterialStateProperty.all(
          theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.focused)) {
            return colorScheme.surfaceContainerHighest;
          }
          return colorScheme.surfaceContainer;
        }),
        elevation: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.focused)) {
            return 2;
          }
          return 1;
        }),
        shadowColor: MaterialStateProperty.all(
          colorScheme.shadow.withOpacity(0.1),
        ),
        surfaceTintColor: MaterialStateProperty.all(
          colorScheme.surfaceTint,
        ),
        side: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.focused)) {
            return BorderSide(
              color: colorScheme.primary,
              width: 2,
            );
          }
          return BorderSide.none;
        }),
        leading: FaIcon(
          FontAwesomeIcons.magnifyingGlass,
          size: 20,
          color: colorScheme.onSurfaceVariant,
        ),
        trailing: [],
        onChanged: onChanged,
      ),
    );
  }
}
