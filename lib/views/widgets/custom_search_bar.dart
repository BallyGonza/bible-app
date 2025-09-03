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
    return SearchBar(
      onTapOutside: (_) => focusNode?.unfocus(),
      focusNode: focusNode,
      autoFocus: autoFocus,
      padding: const MaterialStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 16),
      ),
      controller: controller,
      hintText: hintText,
      hintStyle: MaterialStateProperty.all(
        TextStyle(color: Colors.grey[600]),
      ),
      leading: FaIcon(
        FontAwesomeIcons.magnifyingGlass,
        size: 20,
        color: Colors.grey[600],
      ),
      onChanged: onChanged,
    );
  }
}
