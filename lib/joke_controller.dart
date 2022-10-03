import 'joke.dart';

class JokeController {
  late Map<int, Future<Joke>> jokes;

  JokeController() {
    jokes = {};
  }

  Future<Joke> getJoke(int n) {
    if (!jokes.containsKey(n)) {
      jokes[n] = fetchJoke();
    }
    return jokes[n]!;
  }
}
