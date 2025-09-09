import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
import 'package:bible_app/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Slidable(
        key: ValueKey(index),
        endActionPane: ActionPane(
          extentRatio: 0.25,
          dragDismissible: false,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(8),
              onPressed: (_) {
                showDialog<AlertDialog>(
                  context: context,
                  builder: (context) {
                    return CustomAlertDialog(
                      title: 'Eliminar Nota',
                      content: Text(
                        '¿Estás seguro de que deseas eliminar esta nota?',
                      ),
                      primaryActionTitle: 'Eliminar',
                      onPrimaryPressed: (_) {
                        context
                            .read<NotesBloc>()
                            .add(NotesEvent.deleteNote(index));
                        CustomSnackBar.showSuccess(context,
                            text: 'Nota eliminada');
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              },
              icon: Icons.delete,
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            height: note.content.length > 100 || note.content.contains('\n')
                ? 150
                : note.content.isEmpty || note.title.isEmpty
                    ? note.content.length > 50 || note.content.contains('\n')
                        ? 120
                        : note.content.length > 25 ||
                                note.content.contains('\n')
                            ? 110
                            : 90
                    : 130,
            decoration: BoxDecoration(
              color: Color(note.color),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (note.title.isNotEmpty)
                  Text(
                    note.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: getTextColor(note.color),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                else
                  const SizedBox.shrink(),
                if (note.content.isNotEmpty)
                  const SizedBox(height: 8)
                else
                  const SizedBox.shrink(),
                if (note.content.isNotEmpty)
                  Text(
                    note.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: getTextColor(note.color),
                      fontSize: 16,
                    ),
                  )
                else
                  const SizedBox.shrink(),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (note.author != null && note.author!.isNotEmpty)
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Autor: ',
                              style: TextStyle(
                                color: getTextColor(note.color),
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: note.author,
                              style: TextStyle(
                                color: getTextColor(note.color),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                    Text(
                      note.date,
                      style: TextStyle(
                        color: getTextColor(note.color),
                        fontSize: 14,
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
