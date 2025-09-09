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

  @override
  Widget build(BuildContext context) {
    // Calculate text color based on background color luminance
    Color getTextColor(int backgroundColor) {
      final color = Color(backgroundColor);
      final luminance = color.computeLuminance();
      return luminance > 0.47 ? Colors.black : Colors.white;
    }

    // Calculate appropriate height based on content characteristics
    double _calculateCardHeight(NoteModel note) {
      const double baseHeight = 140.0;
      const double compactHeight = 100.0;
      const double mediumHeight = 120.0;
      const double expandedHeight = 160.0;

      // Check if content is long or contains newlines
      final hasLongContent =
          note.content.length > 100 || note.content.contains('\n');
      final hasMediumContent =
          note.content.length > 50 || note.content.contains('\n');
      final hasShortContent =
          note.content.length > 25 || note.content.contains('\n');

      // Determine if card has minimal content (empty or just title)
      final hasMinimalContent = note.content.isEmpty || note.title.isEmpty;

      if (hasLongContent) {
        return expandedHeight;
      } else if (hasMinimalContent) {
        if (hasMediumContent) {
          return mediumHeight;
        } else if (hasShortContent) {
          return mediumHeight;
        } else {
          return compactHeight;
        }
      } else {
        return baseHeight;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.0),
        child: Card(
          elevation: 2.0,
          shadowColor: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
          color: Color(note.color),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            height: _calculateCardHeight(note),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (note.title.isNotEmpty)
                  Text(
                    note.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: getTextColor(note.color),
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                  )
                else
                  const SizedBox.shrink(),
                if (note.content.isNotEmpty)
                  const SizedBox(height: 12.0)
                else
                  const SizedBox.shrink(),
                if (note.content.isNotEmpty)
                  Expanded(
                    child: Text(
                      note.content,
                      maxLines: note.content.length > 100 ||
                              note.content.contains('\n')
                          ? 3
                          : 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: getTextColor(note.color),
                            height: 1.4,
                          ),
                    ),
                  )
                else
                  const SizedBox.shrink(),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (note.author != null && note.author!.isNotEmpty)
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Autor: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: getTextColor(note.color)
                                          .withOpacity(0.7),
                                      height: 1.3,
                                    ),
                              ),
                              TextSpan(
                                text: note.author,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: getTextColor(note.color),
                                      fontWeight: FontWeight.w600,
                                      height: 1.3,
                                    ),
                              ),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                    Text(
                      note.date,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: getTextColor(note.color).withOpacity(0.7),
                            height: 1.3,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
