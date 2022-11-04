import 'package:hive_flutter/hive_flutter.dart';

import 'package:chuck/models/joke_json/joke_json.dart';
import 'package:chuck/models/reaction/reaction.dart';

part 'joke.g.dart';

@HiveType(typeId: 0)
class Joke {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String text;
  @HiveField(2)
  late Reaction reaction;

  Joke();

  Joke.fromJson([JokeJson? joke]) {
    id = joke!.id;
    text = joke.value;
    reaction = Reaction.nothing;
  }

  Joke.fromValues(
      {required this.id, required this.text, required this.reaction});
}

Joke endOfListJoke() {
  return Joke.fromValues(
      id: 'the-end',
      text: 'This infinite list had been listed till the end by Chuck Norris',
      reaction: Reaction.like);
}
