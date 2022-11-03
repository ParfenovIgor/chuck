import '../../models/joke/joke.dart';
import '../../models/fetcher/fetcher.dart';

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
