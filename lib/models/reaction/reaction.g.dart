// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReactionAdapter extends TypeAdapter<Reaction> {
  @override
  final int typeId = 1;

  @override
  Reaction read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Reaction.nothing;
      case 1:
        return Reaction.like;
      case 2:
        return Reaction.dislike;
      default:
        return Reaction.nothing;
    }
  }

  @override
  void write(BinaryWriter writer, Reaction obj) {
    switch (obj) {
      case Reaction.nothing:
        writer.writeByte(0);
        break;
      case Reaction.like:
        writer.writeByte(1);
        break;
      case Reaction.dislike:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
