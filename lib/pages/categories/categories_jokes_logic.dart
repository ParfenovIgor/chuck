import 'package:chuck/models/fetcher/fetcher.dart';
import 'package:chuck/models/joke/joke.dart';

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
