import '../../models/joke/joke.dart';
import '../../models/fetcher/fetcher.dart';

class SearchJokesLogic {
  static late Future<List<Joke>> jokes;

  static void fetch(String searchQuery) {
    jokes = Fetcher.fetchSearchJokes(searchQuery);
  }

  static Future<List<Joke>> getList() async {
    return jokes;
  }
}
