import '../../models/joke/joke.dart';
import '../../models/fetcher/fetcher.dart';

class RandomJokesLogic {
  static final Map<int, Future<Joke>> jokes = {};

  static Future<Joke> getJoke(int n) {
    if (!jokes.containsKey(n)) {
      jokes[n] = Fetcher.fetchJoke();
    }
    return jokes[n]!;
  }
}
