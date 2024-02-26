// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VerseModelAdapter extends TypeAdapter<VerseModel> {
  @override
  final int typeId = 1;

  @override
  VerseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VerseModel(
      id: fields[0] as int,
      book: fields[1] as String,
      chapter: fields[2] as int,
      verse: fields[3] as int,
      color: fields[4] as String?,
      note: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, VerseModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.book)
      ..writeByte(2)
      ..write(obj.chapter)
      ..writeByte(3)
      ..write(obj.verse)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VerseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
