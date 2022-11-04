import 'package:chuck/models/fetcher/fetcher.dart';
import 'package:chuck/models/joke/joke.dart';

class SearchJokesLogic {
  static late Future<List<Joke>> jokes;

  static void fetch(String searchQuery) {
    jokes = Fetcher.fetchSearchJokes(searchQuery);
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
}
