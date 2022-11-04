import 'package:hive_flutter/hive_flutter.dart';

import 'package:chuck/models/joke/joke.dart';

class SavedJokesLogic {
  static late Future<List<Joke>> jokes;

  static void fetch() async {
    jokes = () async {
      var box = await Hive.openBox<List>('jokes');
      return box.get('list', defaultValue: <Joke>[])!.cast<Joke>();
    }();
  }

  static void store() async {
    var box = await Hive.openBox<List>('jokes');
    await jokes.then((list) {
      box.put('list', list);
    });
  }

  static Future<Joke> getJoke(int n) async {
    late Joke joke;
    await jokes.then((list) {
      if (n < list.length) {
        joke = list[n];
      } else {
        joke = endOfListJoke();
      }
    });
    return joke;
  }

  static Future<bool> addJoke(Joke joke) async {
    bool result = true;
    await jokes.then((list) {
      for (Joke joke2 in list) {
        if (joke.id == joke2.id) {
          joke2 = joke;
          result = false;
        }
      }
      if (result) {
        list.add(joke);
        store();
      }
    });
    return result;
  }

  static void deleteJoke(int n) async {
    await jokes.then((list) {
      if (n < list.length) {
        for (int i = n; i + 1 < list.length; i++) {
          list[i] = list[i + 1];
        }
        list.removeLast();
        store();
      }
    });
  }

  static void delete() async {
    var box = await Hive.openBox<List>('jokes');
    box.clear();
    await jokes.then((list) {
      list.clear();
    });
  }
}
