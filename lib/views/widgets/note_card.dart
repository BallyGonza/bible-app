import 'package:bible_app/blocs/blocs.dart';
import 'package:bible_app/data/data.dart';
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
    return Slidable(
      key: ValueKey(index),
      endActionPane: ActionPane(
        extentRatio: 0.25,
        dragDismissible: false,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(8),
            onPressed: (_) {
              context.read<NotesBloc>().add(NotesEvent.deleteNote(index));
            },
            icon: Icons.delete,
            label: 'Delete',
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
                      : note.content.length > 25 || note.content.contains('\n')
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
                    color: note.color == Colors.white.value
                        ? Colors.black
                        : Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
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
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: note.color == Colors.white.value
                        ? Colors.black.withOpacity(0.6)
                        : Colors.white.withOpacity(0.6),
                    fontSize: 16,
                  ),
                )
              else
                const SizedBox.shrink(),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    note.date,
                    style: TextStyle(
                      color: note.color == Colors.white.value
                          ? Colors.black.withOpacity(0.6)
                          : Colors.white.withOpacity(0.6),
                      fontSize: 14,
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
