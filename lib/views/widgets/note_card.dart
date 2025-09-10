import 'package:bible_app/core/core.dart';
import 'package:bible_app/data/data.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    required this.onTap,
    required this.note,
    required this.index,
    super.key,
  });

  final NoteModel note;
  final int index;
  final VoidCallback onTap;

  // Constants for consistent styling
  static const double _cardHeight = 140.0;
  static const double _cardPadding = 16.0; // Reduced for grid items
  static const double _cardBorderRadius = 12.0; // Slightly smaller for grid
  static const double _contentSpacing = 8.0; // Reduced spacing
  static const double _textHeight = 1.2;

  static const double _luminanceThreshold = 0.3;
  static const double _stateLayerOpacity =
      0.08; // Material 3 state layer opacity

  // Calculate text color based on background color luminance
  Color _getTextColor(int backgroundColor) {
    final color = Color(backgroundColor);
    final luminance = color.computeLuminance();
    return luminance > _luminanceThreshold ? Colors.black : Colors.white;
  }

  // Build title widget if title exists
  Widget _buildTitle(BuildContext context) {
    if (note.title.isEmpty) return const SizedBox.shrink();

    return Text(
      note.title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            // Smaller title for grid
            color: _getTextColor(note.color),
            fontWeight: FontWeight.w600,
            height: _textHeight,
          ),
    );
  }

  // Build content widget if content exists
  Widget _buildContent(BuildContext context) {
    if (note.content.isEmpty) return const SizedBox.shrink();

    return Expanded(
      child: Text(
        note.content,
        overflow: TextOverflow.ellipsis,
        maxLines: 7, // Allow up to 50 lines to fill available space
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              // Smaller content for grid
              color: _getTextColor(note.color).withOpacity(0.9),
            ),
      ),
    );
  }

  // Build author widget if author exists
  Widget _buildAuthor(BuildContext context) {
    if (note.author == null || note.author!.isEmpty)
      return const SizedBox.shrink();

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Autor: ',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _getTextColor(note.color).withOpacity(0.7),
                  fontSize: 10, // Smaller font for grid
                ),
          ),
          TextSpan(
            text: note.author,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _getTextColor(note.color),
                  fontWeight: FontWeight.w600,
                  fontSize: 10, // Smaller font for grid
                ),
          ),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Create state layer color for Material 3 interactions
    final stateLayerColor =
        _getTextColor(note.color).withOpacity(_stateLayerOpacity);

    return InkWell(
      onTap: () async {
        await HapticService.selectionClick();
        onTap();
      },
      borderRadius: BorderRadius.circular(_cardBorderRadius),
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return stateLayerColor.withOpacity(0.12); // Pressed state
          }
          if (states.contains(WidgetState.hovered)) {
            return stateLayerColor.withOpacity(0.08); // Hover state
          }
          if (states.contains(WidgetState.focused)) {
            return stateLayerColor.withOpacity(0.12); // Focus state
          }
          return null;
        },
      ),
      child: Card(
        color: Color(note.color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_cardBorderRadius),
          side: BorderSide(
            color: _getTextColor(note.color).withOpacity(0.12),
            width: 1.0,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(_cardPadding),
          height: _cardHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTitle(context),
              if (note.content.isNotEmpty)
                const SizedBox(height: _contentSpacing),
              _buildContent(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildAuthor(context),
                        if (note.author != null && note.author!.isNotEmpty)
                          const SizedBox(
                              height: 2.0), // Small gap between author and date
                        Text(
                          note.date,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color:
                                    _getTextColor(note.color).withOpacity(0.7),

                                fontSize: 10, // Smaller font for grid
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
