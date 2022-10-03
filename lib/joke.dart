import 'dart:io';
import 'dart:convert';
import 'joke_json.dart';
import 'package:http/http.dart' as http;

Future<Joke> fetchJoke() async {
  try {
    final response =
        await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      JokeJson jokeJson = JokeJson.fromJson(data);
      return Joke(joke: jokeJson);
    } else {
      throw Exception("Could not retrieve data");
    }
  } on SocketException catch (_) {
    throw Exception("Could not connect");
  }
}

enum Reaction {
  nothing,
  like,
  dislike,
}

class Joke {
  late String id;
  late String text;
  late Reaction reaction;

  Joke({required JokeJson joke}) {
    id = joke.id;
    text = joke.value;
    reaction = Reaction.nothing;
  }
}
