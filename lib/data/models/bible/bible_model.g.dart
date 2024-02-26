// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BibleModelAdapter extends TypeAdapter<BibleModel> {
  @override
  final int typeId = 1;

  @override
  BibleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BibleModel(
      id: fields[0] as int,
      name: fields[1] as String,
      version: fields[2] as String,
      books: (fields[3] as List).cast<BookModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, BibleModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.version)
      ..writeByte(3)
      ..write(obj.books);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BibleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
