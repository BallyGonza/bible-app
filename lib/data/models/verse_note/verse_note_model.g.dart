// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_note_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VerseNoteModelAdapter extends TypeAdapter<VerseNoteModel> {
  @override
  final int typeId = 6;

  @override
  VerseNoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VerseNoteModel(
      content: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VerseNoteModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VerseNoteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
