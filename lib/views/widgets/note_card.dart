import 'package:bible_app/data/data.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({required this.note, super.key});

  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(note.color),
      child: ListTile(
        title: Text(
          note.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          note.content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
