import '../../models/joke/joke.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SavedJokesLogic {
  static List<Joke> jokes = [];

  static void fetch() async {
    var box = await Hive.openBox<List>('jokes');
    jokes = box.get('list', defaultValue: <Joke>[])!.cast<Joke>();
  }

  static void store() async {
    var box = await Hive.openBox<List>('jokes');
    box.put('list', jokes);
  }

  static Future<Joke> getJoke(int n) {
    if (n < jokes.length) {
      return Future<Joke>.value(jokes[n]);
    } else {
      return Future<Joke>.value(endOfListJoke());
    }
  }

  static bool addJoke(Joke joke) {
    bool result = true;
    for (Joke joke2 in jokes) {
      if (joke.id == joke2.id) {
        joke2 = joke;
        result = false;
      }
    }
    if (result) {
      jokes.add(joke);
    }
    store();
    return result;
  }

  static void delete() async {
    var box = await Hive.openBox<List>('jokes');
    box.clear();
    jokes.clear();
  }
}
