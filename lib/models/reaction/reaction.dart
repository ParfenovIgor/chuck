import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'reaction.g.dart';

Icon reactionToIcon(Reaction reaction) {
  switch (reaction) {
    case Reaction.nothing:
      return const Icon(Icons.trip_origin);
    case Reaction.like:
      return const Icon(Icons.thumb_up);
    case Reaction.dislike:
      return const Icon(Icons.thumb_down);
  }
}

@HiveType(typeId: 1)
enum Reaction {
  @HiveField(0)
  nothing,
  @HiveField(1)
  like,
  @HiveField(2)
  dislike
}
