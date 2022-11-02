import '../../models/joke/joke.dart';
import '../../models/fetcher/fetcher.dart';

class CategoriesJokesLogic {
  static String category = "";
  static final Map<int, Future<Joke>> jokes = {};

  static Future<Joke> getJoke(int n) {
    if (!jokes.containsKey(n)) {
      jokes[n] = Fetcher.fetchCategoryJoke(category);
    }
    return jokes[n]!;
  }
}
